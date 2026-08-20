# Cómo funciona el demostrador

> **Para entender el código del hito 1** · 17-ago-2026, actualizado el 19-ago tras
> partir el correlador del razonador · Se refiere al repositorio
> `jolmedilla/indramind-demostrador`, rama `particion-correlador-razonador` (PR #2).
>
> Este documento explica el código siguiendo una ejecución real de principio a fin,
> no fichero por fichero. Las trazas que aparecen están capturadas de una ejecución
> de verdad, no inventadas.

---

## 1 · El mapa, en una frase por pieza

Hay tres cosas y conviene no confundirlas nunca:

**El motor** (`src/motor/`) es el producto. Recibe eventos, los correlaciona y emite detecciones con sus hipótesis. No sabe que existe un banco.

**El runner** (`src/runner.py`) es el examinador. Coge una instancia del banco, se la da al motor por la puerta delantera, y comprueba si el resultado cumple lo que la instancia exige.

**El banco** (`banco/instancias/`) son las preguntas del examen: ficheros YAML declarativos que dicen *dado* esto, *cuando* pasa aquello, *entonces* debe ocurrir esto otro.

La frase que lo ordena todo, del canon: **«el arnés interpreta las instancias; el motor jamás las lee»**. Si algún día el motor necesitara leer una instancia, algo se habría roto.

---

## 2 · Una ejecución, de principio a fin

Ejecutamos el escenario REQ-01 —convergencia de fuentes sin evento en agenda— con el perfil completo:

```sh
.venv/bin/python src/runner.py banco/instancias/REQ-01-REF-01.yaml --perfil P1
```

### Lo que hace el runner, por orden

**Primero monta el mundo** (`runner.montar`). Lee la instancia, y de ella:

- Carga el pack que la instancia **fija por versión** (`aglomeraciones-valencia@0.1.0`) y comprueba que el fichero en disco tiene esa versión exacta. Si no coinciden, aborta. Sin versiones fijadas no hay replay, y sin replay no hay INV-05.
- Siembra las **líneas base** del bloque `dado`: para la plaza del Ayuntamiento en franja de tarde, la ocupación tiene media 1450 y desviación 240; las salidas de metro, media 300 y desviación 60; el aforo de paso, media 180 y desviación 40.
- Siembra la **agenda**, que en este escenario está vacía. Esa ausencia es la mitad del caso.
- Crea un **expediente** vacío y un **bus** con el catálogo de esquemas.
- Monta el **correlador** y le **enchufa el detector** que el perfil declare en el pack: el razonador de dominio, o el detector de umbral si el perfil es el ablacionado.

**Después reproduce la cinta** (`runner.reproducir`). Ordena los eventos del bloque `cuando` por tiempo de evento y los publica uno a uno. El motor no distingue esto de la vida real: le llegan eventos por el bus, y ya.

**Por último evalúa** el bloque `entonces`, mirando **solo el expediente**.

### La traza real, con el perfil P1

```
lectura    17:50  salidas_estacion  metro-colon             valor 320   →  0.33 σ
lectura    18:00  salidas_estacion  metro-colon             valor 480   →  3.00 σ
lectura    18:05  aforo_paso        espira-corredor-norte   valor 300   →  3.00 σ
DETECCIÓN  18:05  vencedora: aglomeracion_no_prevista
lectura    18:10  ocupacion_zona    camara-plaza            valor 1900  →  1.88 σ
lectura    18:20  ocupacion_zona    camara-plaza            valor 2400  →  3.96 σ
lectura    18:35  ocupacion_zona    camara-plaza            valor 3200  →  7.29 σ
```

Léelo despacio, porque aquí está todo el argumento del proyecto.

A las 17:50 el metro saca algo más de gente de lo normal: 0,33 desviaciones. Ruido, nada.

A las 18:00 el metro se dispara a 3 desviaciones. Una sola fuente desviada no basta —podría ser una incidencia en otra línea, un partido, un fallo del sensor—, así que el razonador **no dice nada**.

A las 18:05 las espiras del corredor norte también se van a 3 desviaciones. Ahora hay **dos fuentes independientes** desviadas sobre la misma zona dentro de la ventana de 20 minutos. Eso ya no es ruido: es gente yendo hacia la plaza. **Detección.**

Y fíjate en lo que pasa cinco minutos después: a las 18:10 la cámara de la plaza marca 1,88 desviaciones. **La cámara todavía no ve nada raro.** La gente aún no ha llegado. El motor lo dijo antes de que hubiera nada que ver, que es exactamente lo que significa «detección anticipada».

La referencia humana declarada en la instancia son las 18:40. La detección cae a las 18:05, o sea **35 minutos de antelación**, cuando PRE-03 exige 20 para este caso.

---

## 3 · La misma cinta, sin la pieza

Ahora el perfil P0, que es el mismo escenario **con el razonador de dominio quitado** y sustituido por umbrales simples:

```
lectura    17:50  salidas_estacion  →  0.33 σ
lectura    18:00  salidas_estacion  →  3.00 σ
lectura    18:05  aforo_paso        →  3.00 σ
lectura    18:10  ocupacion_zona    →  1.88 σ
lectura    18:20  ocupacion_zona    →  3.96 σ
lectura    18:35  ocupacion_zona    →  7.29 σ
DETECCIÓN  18:35  vencedora: aglomeracion_no_prevista
```

Los eventos son **idénticos**. El motor los ve todos. Pero P0 solo mira un tipo —la ocupación ya consumada— y exige 5 desviaciones para hablar. Las señales de aguas arriba pasan por delante y no le dicen nada, porque no sabe combinarlas.

Resultado: detecta a las 18:35, **5 minutos antes** de que lo hubiera visto un operador. Con la plaza ya llena. Técnicamente ha detectado; operativamente llega tarde.

**Eso es una ablación**, y es lo que convierte una demostración en un argumento. No se trata de enseñar que el sistema funciona: se trata de enseñar que **sin esa pieza no funciona**.

El escenario espejo, REQ-02, hace lo mismo por el otro lado. Misma cinta, pero con una mascletà autorizada en la agenda de 19:00 a 20:00. P1 consulta la agenda, ve que un acto autorizado explica la convergencia —con 90 minutos de margen, porque la gente llega antes— y **no interrumpe a nadie**, dejando escrito que descarta la hipótesis de aglomeración no prevista y por qué. P0 no tiene agenda que consultar, así que hace lo único que sabe: **interrumpe**. Falsa alarma.

Las cuatro ejecuciones juntas dicen: sin la pieza, el sistema **o es ciego o es un histérico**.

---

## 4 · Los módulos, uno a uno

### `motor/eventos.py` — qué puede circular

Define el `Evento` y el `Catalogo` de esquemas. Un evento lleva tipo, **versión de esquema**, entidad, instante, fuente y valor.

Dos decisiones que parecen menores y no lo son:

**El instante es siempre tiempo de evento**, nunca la hora del reloj. Un motor que consultara `datetime.now()` daría resultados distintos en cada pasada y rompería INV-05, que exige que rebobinar dé exactamente lo mismo.

**La entidad es la clave de particionado.** Hoy es una cadena como `zona:plaza-ayuntamiento`; en producción será la clave de partición de Kafka. Está así para que la migración sea honesta (ADR-008).

Un evento cuyo esquema no esté registrado **no entra al bus**. La validación es explícita y en un solo sitio, en vez de repartida en `if`s.

### `motor/bus.py` — por dónde circula

Una cola en memoria que respeta las cinco semánticas de ADR-008: esquemas versionados, suscripciones equivalentes a grupos de consumo, particionado lógico por entidad, ventanas sobre tiempo de evento, y **retención con replay**.

La entrega es síncrona y en orden de publicación. Es deliberado: con una sola hebra el orden es determinista, y sin determinismo no hay INV-05.

`ventana(entidad, hasta, amplitud)` es lo que usa el razonador para preguntar «¿qué más ha pasado en esta zona en los últimos 20 minutos?». Mira hacia atrás desde el instante **de un evento**, no desde la hora actual.

`rebobinar()` vuelve a entregar todo el registro. El motor no distingue una entrega de una reentrega, que es justamente lo que hace verificable la doble pasada con diferencia cero.

### `motor/baselines.py` — qué es normal

Las líneas base estadísticas por entidad, tipo y franja, y la desviación sobre ellas (C-02).

Aquí vive materializado **el reparto que acordaste con Alejandro**: la regla de umbral es doctrina y viaja en el pack; que la media de esta plaza sea 1450 es dato de instalación y llega por la instancia. El pack sirve en Teruel; el 1450 no.

Un detalle de diseño: cuando no hay línea base, `desviaciones()` devuelve `None`, **no cero**. Una ausencia de dato no es una lectura normal. El razonador la anota como ausencia declarada y no la disfraza.

### `motor/expediente.py` — qué se puede afirmar

`Deteccion`, `Hipotesis`, `Interrupcion`, `Evidencia` y el `Expediente` que las agrupa con su traza.

**La detección y la interrupción están separadas a propósito.** Detectar no es interrumpir. REQ-02 mide exactamente eso: cero interrupciones por eventos autorizados en agenda. Si fueran lo mismo, el escenario de la mascletà no se podría escribir.

Cada hipótesis lleva su `prior` —el peso que la doctrina le da antes de mirar la evidencia— y su `grado`, que es **cálculo determinista**. El modelo generativo, cuando exista, propondrá contenidos pero **nunca escribirá grados** (INV-04, ADR-028).

Y las descartadas conservan su `motivo_descarte` escrito, que es lo que exige INV-03: ninguna conclusión adopta explicación única habiendo alternativas plausibles.

### `motor/correlacion.py` — el correlador

Convierte cada evento en una **observación**: la lectura con su desviación ya calculada. Y ahí termina su trabajo. No sabe qué es una aglomeración, ni qué es una mascletà, ni cuándo hay que alarmar.

Detrás se **enchufa un detector**, desde fuera y en tiempo de montaje. Esa costura es la frontera entre lo determinista barato y lo que puede llegar a ser caro: el correlador mira todos los eventos, el detector solo se despierta cuando hay algo que mirar. Sin ella no hay forma de que el coste crezca sublinealmente con las fuentes (PRE-04) ni de etiquetar qué juicio es determinista y cuál generativo (INV-10).

También es la única puerta a los datos crudos: un detector nunca toca el bus ni las líneas base, le pregunta al correlador por la ventana.

### `motor/dominio.py` — el razonador de dominio

La pieza cuyo valor mide la ablación. Hace las dos cosas que una capa determinista genérica no puede hacer, porque son conocimiento de dominio y viajan en el pack.

**Sumar señales que por separado no dirían nada.** `_converge()` cuenta cuántas **fuentes distintas** están desviadas dentro de la ventana. Que sean distintas es lo que evita que baste con una fuente ruidosa disparándose sola.

**Preguntar por lo previsto antes de alarmar.** `_hipotesis()` consulta la agenda como discriminante. Con evento autorizado gana «evento esperado» y se descarta la otra con su motivo escrito; sin él, al revés. Nunca una sola explicación habiendo alternativas plausibles (INV-03).

### `motor/detectores.py` — lo común, y el término de comparación

La clase base guarda las tres obligaciones de todo detector: una detección por hecho físico (INV-11), adjuntar la evidencia de la ventana, y pasar por la política antes de interrumpir.

Y aquí vive `DetectorUmbral`, que es **el perfil P0**: lo único que puede hacer un sistema sin conocimiento de dominio, mirar un número y compararlo con una línea. Su dilema no tiene salida: con el listón alto llega tarde, con el listón bajo llena la sala de falsas alarmas. Y como no tiene a quién preguntar por lo previsto, solo puede formar una explicación — lo que ya incumple INV-03 por sí mismo.

### `motor/agenda.py` y `motor/politica.py`

La agenda es la forma **declarada** de la línea base (C-02): no la estadística sino el plan, la orden o el acto autorizado, cuyo incumplimiento también es desviación. Es un **consultable**, no una fuente: nadie la publica en el bus.

La política de interrupción (C-09) está aparte porque es una decisión de otra naturaleza. Un detector dice qué está pasando; la política dice si eso merece robarle la atención a una persona. **La vigilancia continúa en ambos casos**; lo que cambia es si suena algo.

### `motor/ensamblaje.py` — qué lleva cada perfil

Aquí la ablación se vuelve estructural. Un perfil no es un parámetro que cambie el comportamiento de una clase: es **qué se enchufa detrás del correlador**, declarado por su nombre en el pack. El perfil sin razonador de dominio se obtiene no montándolo.

### `src/runner.py` — el examinador

Ya recorrido arriba. Lo que importa recordar son las **tres propiedades** que el banco le exige y que cumple:

| Propiedad | Qué significa aquí |
|---|---|
| **Solo puerta delantera** | Todo entra por el bus y los consultables. Ningún gancho de prueba altera el motor, y el motor no sabe que lo examinan |
| **El runner es dueño del reloj** | Los instantes salen de la cinta; el motor nunca consulta la hora del sistema |
| **El expediente es la única superficie de aserción** | Las comprobaciones miran lo que el expediente expone, no el estado interno del motor |

Y una cuarta que no es del canon sino tuya: **el runner ejecuta y declara verde o rojo, pero no interpreta**. Que el rojo de P0 sea el resultado buscado lo dice la suite, no el instrumento.

---

## 5 · La anatomía de una instancia

Los cinco bloques que declara `banco/README.md` del canon:

| Bloque | Qué lleva |
|---|---|
| **identidad** | `REQ-xx-<MUNDO>-nn`, de qué fila es instancia, etiquetas |
| **versiones fijadas** | pack, doctrina del despliegue, configuración semántica. Sin esto no hay replay |
| **dado** | lo que ya existe: líneas base, agenda, la referencia humana de PRE-03 |
| **cuando** | la cinta de eventos con su tiempo de evento |
| **entonces** | las aserciones legibles por máquina, y las métricas |

Las aserciones son un **vocabulario cerrado** —`existe_deteccion`, `hipotesis_en_competencia`, `hipotesis_vencedora`, `alternativa_descartada_con_motivo`, `antelacion_minima`, `interrupciones_maximo`— y no expresiones arbitrarias. Es deliberado: CFG-05 exige que un experto de dominio que no programa pueda escribir y leer un escenario. Cada aserción nueva es una entrada de vocabulario que hay que implementar en el runner.

Las dos instancias del hito 1 **comparten cinta y líneas base** y solo difieren en la agenda. Eso hace visible que lo que cambia el desenlace es el discriminante, no la señal.

---

## 6 · Qué no hay, y qué está en duda

**No hay** razonador de incidente (es el hito 2), ni persistencia —el expediente vive en memoria—, ni capa de demostración, ni invocación generativa. Todo lo que hay es determinista: la mitad de abajo de la arquitectura.

**Está sujeto a revisión**, y conviene que lo tengas presente al estudiarlo:

- **El esquema de instancia.** Es una primera forma nacida de dos escenarios. `banco/README.md` lo declara decisión de construcción de la PoC, así que se puede mover, pero acabará entrando al canon por la bandeja.
- **El margen de antelación de 90 minutos.** Es doctrina y es discutible.
- **El bloque `ablacion`** de las instancias, que el runner no lee. El canon dice que el uso vive en suites, así que probablemente deba mudarse allí.

**Y hay una deuda anotada:** el runner monta el motor **por importación, en el mismo proceso**. Eso da por supuesto que motor y runner comparten lenguaje. POC-005 no llama al runner andamiaje sino «infraestructura de aceptación permanente», y su destino es examinar dos implementaciones. El día que tenga que examinar una que no sea esta, la puerta delantera tendrá que ser una **frontera de proceso** —el runner hablando con el motor por HTTP o por el bus real—. Antes de septiembre no hace falta.

---

## 7 · Trabajo pendiente, en orden

De la revisión del código del 18-ago-2026, tras leer este documento. Tres conclusiones, dos de ellas nuevas.

### 7.1 · ~~Partir `dominio.py` en correlador y razonador~~ — **hecha el 19-ago-2026**

Hoy `RazonadorDominio` acumula cuatro responsabilidades que el canon separa: evaluar la desviación contra la línea base (C-02), **correlacionar** fuentes independientes por espacio, tiempo y entidad (C-03), **formar las hipótesis en competencia** con los priores de la doctrina (C-04), y decidir si se interrumpe a un puesto (la política de interrupción, C-09). La correlación —`_converge()`— es CEP de manual y está pegada al razonamiento de verdad.

Hoy no se nota porque todo es determinista. Se notará en cuanto el razonador llame al modelo, por dos motivos normativos: el coste debe crecer sublinealmente con las fuentes, lo que exige que algo barato decida **cuándo** despertar a lo caro (PRE-04); y cada juicio va etiquetado como determinista o generativo (INV-10), lo que exige saber dónde acaba uno y empieza el otro.

**El motivo más fuerte es de argumento, no de ingeniería.** Hoy la ablación es un parámetro del pack: P0 y P1 son el mismo código con otro umbral, y alguien puede decir con razón «habéis subido el umbral y por eso falla». Si el corte fuera estructural —P0 es el correlador solo; P1 es el correlador **más el razonador enchufado detrás**— la ablación sería literalmente quitar una pieza. El argumento se vuelve mucho más difícil de rebatir.

**Hecha.** El correlador emite observaciones; el razonador de dominio y el detector de umbral son dos piezas distintas que se enchufan detrás, declaradas por su nombre en el pack; la agenda y la política de interrupción salen a sus propios módulos. Las cuatro ejecuciones dan el mismo resultado que antes, comprobado. Va en la PR #2 del demostrador.

### 7.2 · Un adaptador para poder examinar otras implementaciones — después

El acoplamiento no es de lenguaje, como estaba anotado en §6: **es de forma**. El runner da por supuesto que la puerta de entrada es un objeto con `publicar(Evento)`, y otra implementación podría ingerir por Kafka, REST, gRPC o fichero. Y no monta solo el razonador: carga el pack y construye líneas base, agenda, expediente, **bus** y razonador, cableándolos. Es el ensamblador del sistema que examina.

El canon pide menos de lo que hemos implementado: «solo puerta delantera» es un contrato semántico —bus, consultables y API de acciones—, no una clase.

**Alcance:** un adaptador de tres verbos, `sembrar(dado)`, `publicar(evento)` y `expediente()`. Hoy uno en proceso; mañana uno por HTTP. **Las instancias del banco no cambian ni una línea**: el banco sigue siendo el contrato y solo cambia el enchufe. Consecuencia asumida: el expediente pasa a ser un esquema de intercambio, que es lo que el canon ya pide al exigirlo autosuficiente y única superficie de aserción (REQ-40).

No aporta nada a septiembre y se diseña mejor con el motor ya partido por dentro, así que va después de 7.1.

### 7.3 · Una opción `--traza` en el runner — barata y útil

Para ver el paso a paso hay que montar el mundo a mano desde Python. Es la herramienta que más ayuda a estudiar y a depurar, y es un rato de trabajo.

---

## 8 · Cómo reproducir todo esto

```sh
cd indramind-demostrador
python3 -m venv .venv
.venv/bin/pip install -r src/requirements.txt

# Un escenario
.venv/bin/python src/runner.py banco/instancias/REQ-01-REF-01.yaml --perfil P1

# Las cuatro ejecuciones de la ablación
for f in REQ-01-REF-01 REQ-02-REF-01; do
  for p in P1 P0; do
    .venv/bin/python src/runner.py banco/instancias/$f.yaml --perfil $p
  done
done
```

Para ver la traza paso a paso, como la de este documento, hay que montar el mundo a mano desde Python e imprimir `expediente.traza`. No hay todavía una opción de línea de órdenes para eso, y sería una mejora barata y útil.
