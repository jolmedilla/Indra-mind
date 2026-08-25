# Cómo funciona el demostrador

> **Para entender el código del hito 1** · 17-ago-2026 · Actualizado el 25-ago tras
> la resolución de objeto (PR #3), la salida de la doctrina del código (PR #4) y
> la opción `--traza` (PR #5) · Se refiere al repositorio
> `jolmedilla/indramind-demostrador`, rama `main`.
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

**El canon** (`indramind-poc/`) es un **submódulo** desde el 25-ago, y no es una copia sino un puntero a un commit. De él salen los segmentos consagrados —las cintas que el banco referencia—, y que el puntero fije uno concreto es lo que impide que una fixture cambie bajo los pies del repositorio: un replay contra un segmento que se movió no es el mismo replay (INV-05).

La frase que lo ordena todo, del canon: **«el arnés interpreta las instancias; el motor jamás las lee»**. Si algún día el motor necesitara leer una instancia, algo se habría roto.

Y una distinción que aparece más abajo y conviene tener ya: **un objeto no es una detección.** Un objeto es «esto de aquí, del que hablan estas lecturas»; una detección es «y esto de aquí es una aglomeración no prevista». El primero lo resuelve el correlador sin saber de dominio; la segunda la forma un razonador con la doctrina delante.

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

Desde la PR #3, cada esquema declara además **cómo se resuelve la entidad** de su clase. Hay dos maneras y conviven: la fuente anclada la trae puesta —una cámara atornillada a una plaza publica lecturas que ya dicen `zona:plaza-ayuntamiento`— y la fuente que informa de un punto del mundo no la sabe. Quien llama al 112 no dice «el incendio DET-4471»: dice unas coordenadas. Cuál se aplica es configuración semántica, no doctrina.

### `motor/geo.py` — dónde está cada cosa

Puntos con su incertidumbre y la distancia entre ellos, y nada más. Es la función de catálogo `distancia_geo` que los packs del canon declaran y no implementan.

Un punto no es una coordenada: es una coordenada **con su incertidumbre**. Quien llama al 112 desde la acera de enfrente da un punto a cuarenta metros del fuego, y esos cuarenta metros no son un error a corregir sino un dato a arrastrar. Perderlos es perder lo único que permite decidir si dos lecturas hablan del mismo hecho.

### `motor/resolucion.py` — de qué hecho del mundo habla cada evento

La pieza que sostiene la ley del objeto único (REQ-07, INV-11). Hasta la PR #3 esa ley se cumplía **por un atajo**: los eventos traían la entidad puesta, así que dos lecturas del mismo sitio hablaban del mismo sitio por construcción. Eso vale para una cámara atornillada a una plaza y no vale para nada más.

La regla de fusión es corta: un evento se une al objeto vivo más cercano cuyos círculos de error toquen el suyo, dentro de la ventana. **Nadie inventa un radio de fusión**: lo ponen las fuentes al declarar lo mal que saben dónde están. Si ninguno cumple, nace un objeto nuevo.

Fusiona por espacio y tiempo y nada más. No mira las temáticas de la llamada, no sabe qué es un fuego, no consulta ningún pack: es la capacidad C-03 y termina donde empieza el dominio.

### `motor/combinador.py` — el único sitio donde se escribe un grado

Que sea el único no es estilo: la instancia cero del banco lleva entre sus métricas «grados escritos fuera del combinador: 0» (ADR-028), y esa cifra solo significa algo si hay un combinador que nombrar.

La regla, escrita: se parte del prior que la doctrina asigna, y cada discriminante lo mueve — `refuerza` acerca a la certeza, `descarta` acerca al suelo —, las dos multiplicativas sobre lo que queda por recorrer. Consecuencia buscada: **ningún discriminante lleva el grado a 1 ni a 0**, porque una hipótesis descartada se tacha con su motivo y sigue consultable, no se borra (INV-03).

Lo que no es, y está dicho en el módulo: no es actualización bayesiana, y los pesos no son verosimilitudes.

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

Hace dos capacidades del canon y termina ahí. **C-03**, situar cada evento en su objeto, con la ayuda del resolutor. Y **C-02**, calcular cuánto se aparta de lo normal la lectura, cuando hay línea base contra la que compararla. Con las dos, cada evento se convierte en una **observación**.

El orden importa y es este: **primero el objeto, después la medida.** Un motor que midiera antes de saber de qué habla la lectura tendría que elegir contra qué línea base compararla sin saber de qué hecho es.

La desviación puede venir vacía, y esa vacuidad es información: una llamada al 112 no tiene línea base como un nombre no tiene temperatura. Lo que **no** debe hacer nadie es leer el hueco como normalidad.

Detrás se **enchufan razonadores** —cero, uno o varios—, desde fuera y en tiempo de montaje. Esa costura es la frontera entre lo determinista barato y lo que puede llegar a ser caro: el correlador mira todos los eventos, el razonador solo se despierta cuando hay algo que mirar. Sin ella no hay forma de que el coste crezca sublinealmente con las fuentes (PRE-04) ni de etiquetar qué juicio es determinista y cuál generativo (INV-10).

Con cero razonadores el motor resuelve objetos y no concluye nada. No es un modo de pruebas: es lo que hay por debajo de toda doctrina, y es el motor que hace falta para asertar la parte de la ley del objeto único que no depende de ningún pack.

También es la única puerta a los datos crudos: un razonador nunca toca el bus ni las líneas base, le pregunta al correlador por la ventana.

### `motor/dominio.py` — el razonador de dominio

La pieza cuyo valor mide la ablación. Hace las dos cosas que una capa determinista genérica no puede hacer, porque son conocimiento de dominio y viajan en el pack.

**Sumar señales que por separado no dirían nada.** `_converge()` cuenta cuántas **fuentes distintas** están desviadas dentro de la ventana. Que sean distintas es lo que evita que baste con una fuente ruidosa disparándose sola.

**Preguntar por lo previsto antes de alarmar.** `_hipotesis()` resuelve contra los consultables los discriminantes que la doctrina declara. Con evento autorizado gana «evento esperado» y se descarta la otra con su motivo escrito; sin él, al revés. Nunca una sola explicación habiendo alternativas plausibles (INV-03).

**Y aquí no hay doctrina, que es la novedad de la PR #4.** Hasta entonces este módulo sabía que las hipótesis eran dos y cómo se llamaban, sabía que sin agenda la convergencia vale 0,82 y con agenda 0,12, y llevaba escritos en castellano los motivos de descarte. Eso no es capacidad del motor: es doctrina, y la doctrina es configuración versionada con dueño y ciclo propios (ADR-022).

Lo que queda es saber interrogar un consultable, recorrer los discriminantes y pedirle el grado al combinador. La prueba de que la separación es real: **añadir una tercera explicación al dominio no toca ningún fichero `.py`.**

Un detalle que parece menor y no lo es: los consultables se preguntan **una vez por caso**, no una por hipótesis. Si cada hipótesis preguntara por su cuenta, nada garantizaría que vieran la misma respuesta, y la traza mostraría un motivo de descarte que contradice al de al lado.

### `motor/detectores.py` — lo común, y el término de comparación

La clase base guarda las tres obligaciones de todo detector: una detección por hecho físico (INV-11), adjuntar la evidencia de la ventana, y pasar por la política antes de interrumpir.

Y aquí vive `DetectorUmbral`, que es **el perfil P0**: lo único que puede hacer un sistema sin conocimiento de dominio, mirar un número y compararlo con una línea. Su dilema no tiene salida: con el listón alto llega tarde, con el listón bajo llena la sala de falsas alarmas. Y como no tiene a quién preguntar por lo previsto, solo puede formar una explicación — lo que ya incumple INV-03 por sí mismo.

Cuál es esa única explicación lo dice el pack, en `hipotesis_unica` de su perfil. Importa que se lea ahí: la carencia de P0 forma parte de lo que la ablación demuestra, y una carencia escondida en un fichero de Python no la puede enseñar nadie en una reunión.

### `motor/agenda.py` y `motor/politica.py`

La agenda es la forma **declarada** de la línea base (C-02): no la estadística sino el plan, la orden o el acto autorizado, cuyo incumplimiento también es desviación. Es un **consultable**, no una fuente: nadie la publica en el bus.

La política de interrupción (C-09) está aparte porque es una decisión de otra naturaleza. Un razonador dice qué está pasando; la política dice si eso merece robarle la atención a una persona. **La vigilancia continúa en ambos casos**; lo que cambia es si suena algo. Qué explicaciones no interrumpen lo declara el pack desde la PR #4; estuvo cableado aquí, con un comentario que ya prometía mudarlo.

### `motor/ensamblaje.py` — qué lleva cada perfil

Aquí la ablación se vuelve estructural. Un perfil no es un parámetro que cambie el comportamiento de una clase: es **qué razonadores se enchufan detrás del correlador**, declarados por su nombre en el pack. El perfil sin razonador de dominio se obtiene no montándolo.

Los razonadores viven en una **tabla**, no en una cadena de condiciones, y el perfil declara una **lista**. No es previsión gratuita: el canon declara P2 —«dominio más incidente»— y P3 —el sistema completo—, que son varios razonadores a la vez, y el hito 2 llega ahí.

Es además el único sitio del motor donde se ven a la vez la **configuración semántica** —el catálogo de esquemas— y la **doctrina** —el pack—. El montaje es la costura entre las dos.

### `src/runner.py` — el examinador

Ya recorrido arriba. Desde la PR #3 sabe además leer un **segmento consagrado** del canon en vez de una cinta escrita dentro de la instancia, y desde la PR #5 tiene **`--traza`**, que imprime el paso a paso antes del veredicto: cada lectura con su distancia a lo normal, el nacimiento de cada objeto, cada detección con sus hipótesis y el motivo de la descartada, y cada interrupción con su destinatario.

La traza no cambia nada de lo que el motor hace: lee el expediente, que es la única superficie que el arnés mira. Lo que importa recordar son las **tres propiedades** que el banco le exige y que cumple:

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

Las aserciones son un **vocabulario cerrado** —`existe_deteccion`, `hipotesis_en_competencia`, `hipotesis_vencedora`, `alternativa_descartada_con_motivo`, `antelacion_minima`, `interrupciones_maximo`, y desde la PR #3 `objetos_totales`, `embudo`, `linea_temporal`, `fuentes_convergentes` y `reparto_unico`— y no expresiones arbitrarias. Es deliberado: CFG-05 exige que un experto de dominio que no programa pueda escribir y leer un escenario. Cada aserción nueva es una entrada de vocabulario que hay que implementar en el runner.

Las dos instancias del hito 1 **comparten cinta y líneas base** y solo difieren en la agenda. Eso hace visible que lo que cambia el desenlace es el discriminante, no la señal.

### La tercera instancia: la noche de la nave de pinturas

`REQ-07-VLC-01` es distinta de las dos anteriores en tres cosas, y las tres importan.

**Su cinta no está aquí.** Vive en el segmento consagrado `VLC-nave-pinturas-01` del canon, que el repositorio trae como submódulo. No se copia a propósito: una copia hereda el deber de barrido de ADR-061 y envejece; un puntero fija el commit exacto contra el que esto se verificó.

**No fija ningún pack, y se monta sin doctrina.** Los dos packs del caso —incendio urbano industrial y mercancías peligrosas— todavía no se montan, y fijar una versión que no se monta sería mentir justo donde el arnés debe abortar.

**Declara su cobertura parcial, y el runner la imprime en cada ejecución.** Cubre la aserción (a) del contrato canónico —siete eventos, un solo hecho del mundo— y la aserta un peldaño por debajo de donde el canon la escribe: sobre el objeto, no sobre la detección. Quedan (b) a (e): clase y reclasificación, el segundo pack y sus despertares de profundidad uno, las consultas con su resultado literal citado, y la pizarra final.

Es **la primera instancia de aceptación común de todas las líneas de construcción** (POC-007), así que no es una instancia más: es el examen que cualquier otro intento de construir el demostrador tendrá que pasar igual.

---

## 6 · Qué no hay, y qué está en duda

**No hay** razonador de incidente (es el hito 2), ni persistencia —el expediente vive en memoria—, ni capa de demostración, ni invocación generativa. Todo lo que hay es determinista: la mitad de abajo de la arquitectura.

**Está sujeto a revisión**, y conviene que lo tengas presente al estudiarlo:

- **El esquema de instancia.** Es una primera forma nacida de tres escenarios. `banco/README.md` lo declara decisión de construcción, así que se puede mover, pero acabará entrando al canon por la bandeja.
- **El margen de antelación de 90 minutos**, y ahora también **la escala de pesos** del pack y la regla del combinador. Son doctrina y son discutibles.
- **El bloque `ablacion`** de las instancias, que el runner no lee. El canon dice que el uso vive en suites, así que probablemente deba mudarse allí.
- **El token `REF`** de nuestros identificadores. El canon dice que el token de hoy es `VLC` y que `REF` llega cuando la ciudad se generalice: vamos por delante y hay que alinearlo.
- **La regla de fusión geoespacial.** No deshace fusiones, no fusiona por identidad citada —una matrícula, un número de instalación—, y no envejece los objetos más allá de la ventana. Las tres hacen falta y ninguna hacía falta para la aserción (a).

**Y hay una deuda anotada, con su justificación ya caducada.** El runner monta el motor por importación, en el mismo proceso. Este documento decía que el problema era el día que tuviera que examinar **otra** implementación, citando POC-005.

**POC-007 retiró esa premisa el 23-ago:** el arnés ejecutable es construcción y queda fuera del canon, y *el runner es de cada línea*. Ninguna línea examina la implementación de otra. Lo que hace comparables a las líneas no es un arnés común sino el **banco** —las mismas instancias— y el **contrato de observables** —las mismas emisiones—.

Lo que sí sobrevive de la deuda es lo otro que decía: el runner no monta solo el razonador, sino que **carga el pack y cablea líneas base, agenda, expediente, bus y razonadores**. Sabe demasiado del motor por dentro. Y su otra mitad —«el expediente pasa a ser un esquema de intercambio»— es exactamente el **contrato de observables**, que la POC-007 dejó como pendiente declarado y que es el hueco con nuestro nombre.

---

## 7 · Trabajo pendiente, en orden

Abierto tras la revisión del código del 18-ago-2026 y puesto al día el 25-ago.

### 7.1 · ~~Partir `dominio.py` en correlador y razonador~~ — **hecha el 19-ago-2026**

`RazonadorDominio` acumulaba cuatro responsabilidades que el canon separa: evaluar la desviación contra la línea base (C-02), **correlacionar** fuentes independientes (C-03), **formar las hipótesis en competencia** con los priores de la doctrina (C-04), y decidir si se interrumpe a un puesto (C-09).

**El motivo más fuerte era de argumento, no de ingeniería.** Con la ablación como parámetro del pack, alguien podía decir con razón «habéis subido el umbral y por eso falla». Con el corte estructural, la ablación es literalmente quitar una pieza.

**Hecha.** Va en la PR #2.

### 7.2 · ~~Sacar la doctrina del código~~ — **hecha el 25-ago-2026**

No estaba en la lista original y apareció al preparar el hito 1 para enseñarlo: la partición de 7.1 dejó las piezas bien separadas, pero **dentro de la pieza del razonador seguía habiendo doctrina escrita a mano** — los grados 0,82, 0,10, 0,91 y 0,12, los motivos de descarte en castellano, y en `politica.py` qué explicación no interrumpe —.

Era el mismo problema de 7.1 un peldaño más adentro: cuesta sostener que P0 y P1 son piezas distintas cuando quien abre el fichero encuentra números puestos a mano.

**Hecha.** Pack en 0.2.0, combinador como único sitio donde se escribe un grado, y el montaje como tabla con perfiles que declaran una lista de razonadores. Va en la PR #4.

### 7.3 · ~~Una opción `--traza` en el runner~~ — **hecha el 25-ago-2026**

Se ganó el sueldo antes de terminarse: destapó que el correlador anotaba ausencia declarada de dato para toda lectura cualitativa, y la noche de la nave producía siete avisos falsos. Va en la PR #5.

### 7.4 · El adaptador de tres verbos — **replanteado**

Estaba justificado por «el día que tenga que examinar otras implementaciones», y **POC-007 retiró esa premisa**: el runner es de cada línea. Lo que sobrevive es que el runner es el ensamblador del motor que examina, y sobre todo su otra mitad: que el expediente pase a ser un **esquema de intercambio**, que es el contrato de observables. Deja de ser una tarea de fontanería y pasa a ser el camino que más nos posiciona.

### 7.5 · Lo que viene, en orden

1. **Alinear `REF` → `VLC`** en nuestros identificadores.
2. **Dos propuestas al canon, antes del lote IV:** el pack de aglomeraciones, que POC-007 dice que los insumos compartidos se producen una sola vez en el canon; y las escenas de REQ-01 y REQ-02 con nuestros números ejecutados, que ahora **sí** son verificables desde donde José mira.
3. **Rebanadas 2 y 3 de la noche de la nave**, que cierran las aserciones (b) a (e) y con ellas las seis observables.
4. **La letra definitiva del contrato de observables**, que es el pendiente declarado de la POC-007 y lo único que nadie más puede escribir con fundamento, por ser esta la única línea que ha ejecutado un banco con un arnés de verdad.

---

## 8 · Cómo reproducir todo esto

```sh
cd indramind-demostrador
git submodule update --init                     # el canon, de donde salen los segmentos
python3 -m venv .venv
.venv/bin/pip install -r src/requirements.txt

# Un escenario, con el paso a paso
.venv/bin/python src/runner.py banco/instancias/REQ-01-REF-01.yaml --perfil P1 --traza

# Las cuatro ejecuciones de la ablación
for f in REQ-01-REF-01 REQ-02-REF-01; do
  for p in P1 P0; do
    .venv/bin/python src/runner.py banco/instancias/$f.yaml --perfil $p
  done
done

# La noche de la nave: siete eventos, un solo hecho del mundo
.venv/bin/python src/runner.py banco/instancias/REQ-07-VLC-01.yaml --traza
```

La traza de este documento sale ya de `--traza`; hasta el 25-ago había que montar el mundo a mano desde Python.
