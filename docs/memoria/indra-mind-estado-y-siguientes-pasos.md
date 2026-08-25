---
name: indra-mind-estado-y-siguientes-pasos
description: "Punto de continuación del trabajo de IndraMind: estado al 25-ago-2026 por la tarde, con la rebanada del objeto único construida, la PROP-031 en la bandeja y el orden de trabajo decidido para acabar H1"
metadata:
  node_type: memory
  type: project
---

Estado al **25-ago-2026**. Contexto general en [[indra-mind-engagement]]; el canon en [[indramind-poc-repo-canon]]; cómo quiere José que se trabaje en [[instrucciones-jose-proyecto-indramind]]; lo administrativo en [[alta-autonomo-y-contratacion-malt]].

## Lo primero al abrir sesión

**El canon se mueve muy rápido.** Entre el 19 y el 25 de agosto José pasó de la PROP-012 a la PROP-030. Hacer `git submodule update --remote indramind-poc` y mirar qué ha entrado **antes de opinar de nada**: lo que aquí se diga puede haber caducado.

## El modelo cambió: ya no es una PoC, es un demostrador con N líneas

**POC-007, del 23-ago-2026**, y reordena el encargo:

- **«PoC» se retira.** El ejercicio de la iteración 1 es el **demostrador** (el de València); cada intento independiente de construirlo es una **línea de construcción**; la **demo** es el acto de demostración ante la audiencia.
- **El demostrador admite N líneas independientes**, cada una en su repositorio, **sin comunicación de código ni de diseño entre ellas**, con la misma caja temporal y fecha de demo común contra la suite congelada. Valor declarado: **contraste** —la especificación demuestra que basta por sí misma si líneas independientes la ejecutan hasta verde— y **redundancia**. Lo de Juanjo es **una línea**, y puede no ser la única.
- **El demostrador no es la semilla del producto.** Queda superseded la cláusula de semilla única de POC-005. El activo persistente es el canon.
- **`/src` desaparece del plan del repo canónico**, y **el arnés ejecutable es construcción y queda fuera del canon** (ADR-035). El runner es de cada línea.
- Lo que el canon **sí** posee: el contenido del banco y el **contrato de observables** que toda línea debe poder emitir.

## El hueco que nos toca: el contrato de observables

Vive como **borrador** en `banco/contrato-observables.md`, nacido de las aserciones que exigió de verdad el replay de la instancia cero. Seis observables mínimas: detecciones con clase y versión de pack; registro de despertares con su disparador; hipótesis con grados, estado y motivo de descarte; consultas con resultado literal; interrupciones con destinatario; e instantáneas de pizarra comparables entre pasadas.

**Su letra definitiva es pendiente declarado de la POC-007.** Y el propio borrador declara qué no resuelve: «el formato de serialización, el transporte, la granularidad temporal de las instantáneas… y el encaje con el esquema concreto de instancia y el validador `check_banco`».

**Eso es exactamente lo que Juanjo tiene resuelto empíricamente y nadie más**, por ser el único que ha ejecutado un banco con un arnés de verdad. Es el hueco con su nombre, y además es lo que define lo que íbamos a construir como adaptador: la puerta delantera como frontera de proceso **ya tiene dueño y nombre en el canon**, y no hay que inventársela.

## Nuestras instancias han quedado fuera de convención

El banco nació el 23-ago con **POC-006**, y la forma no es la que teníamos:

- Instancias en **Markdown**, no YAML, con el modelo historia-más-contrato y los cinco bloques.
- Identificador `REQ-xx-<MUNDO>-nn` con el token **`VLC`** hoy, y migración declarada a `REF` cuando la ciudad se generalice.
- **Las ablaciones son instancias propias `ABL-nn`**, y sus expectativas viven en las instancias ABL y en las suites versionadas, **«nunca dentro de la instancia normativa»**. Eso confirma y generaliza lo que ya sospechábamos del bloque `ablacion` que metimos dentro de las instancias.
- **Perfiles ampliados:** P0 (umbrales simples), P1 (solo dominio), P2 (dominio más incidente), P3 (completo), «solo cámara», D1/D2 (doctrina inicial y corregida) y destino±aguas-arriba. Nuestros P0 y P1 encajan con la nomenclatura nueva.

**Y la instancia de aceptación común no es la nuestra.** Es **`REQ-07-VLC-01`**, la ley del objeto único sobre la noche de la nave de pinturas: seis llamadas al 112 y una analítica de cámara que deben producir **una sola detección**, con dos packs (incendio y mercancías peligrosas), reclasificación y despertares de profundidad uno. Es «la primera instancia de aceptación común de las líneas de construcción». **El motor de Juanjo no hace nada de eso todavía.**

## Terminología nueva que hay que usar

- **«Recorrido en seco»** sustituye a «verde manual» (POC-008), y tiene **dos capas**: la determinista y el ensayo generativo (POC-009).
- **«Pares de garantía»** sustituye a «par de endurecimiento» y «variante firmable» (POC-010).
- **«Obligatorias» y «deseables»** sustituyen a «núcleo» y «extensiones baratas» del alcance del demostrador (POC-011).

## Qué pasó con nuestra PROP-012

**Aceptada con cambios el 22-ago y aplicada ese mismo día.** Los dos capítulos de encuadre viven en `docs/apoyo/guia-requisitos-para-construccion.md`, como **guía aparte** — ni fusionada en el maestro ni documento canónico nuevo, que eran los dos caminos que ofrecíamos —, que viaja con cada edición del documento de requisitos.

Tres cosas que José cambió y conviene no repetir:

1. **Línea roja con los ADR.** Tumbó el anexo que los listaba: «las decisiones son del equipo de negocio, y los ADR son un mecanismo interno nuestro… hablar de los ADR en un anexo abre la puerta a la petición de compartir ese repo, y esa es una línea roja». En su lugar, marco de gestión de cambios: se visibilizan **los cambios del documento**, no las decisiones que llevaron a ellos.
2. **Quitó nuestros números de la ablación** —los 35 y los 5 minutos— porque verificó que `/src` estaba vacío en el canon desde la reversión del 14-ago y no eran comprobables desde donde él miraba. Lección: **no citar como hecho nada que el lector no pueda verificar en el repositorio que tiene delante.**
3. **«Sin bandos»:** «ninguna de las dos partes» pasó a «ni quien especifica ni quien construye».

De ese veredicto nacieron **PROP-014** (frontera de entrega) y **PROP-015** (las tres propiedades del arnés a la letra normativa de §8), ambas ya aplicadas.

## Estado del canon (`origin/main` = `0567d42`)

Requisitos **v0.5.11** · **ADR-001..062** · **POC-001..011** · índice **v3.48**.

Bandeja: **pendientes PROP-013, 016, 019, 022 y la nuestra, la PROP-031**, empujada el 25-ago por la tarde. `banco/instancias/` tiene la instancia cero y `banco/suites/` la suite del demostrador de València, en v0.1 y **en construcción**: hasta la congelación de septiembre, la suite propone y no obliga.

## Dónde está nuestro código

`jolmedilla/indramind-demostrador`. **Las PR #1 y #2 se fusionaron el 25-ago** (`aed4663` y `87fdcdd`): la regla de trabajar con pull requests, y la partición del correlador y el razonador. **La PR #3 está abierta** con la rebanada del objeto único.

El correlador convierte eventos en observaciones y no sabe de dominio; detrás se enchufa un detector, y `P0` y `P1` son **dos clases distintas**, no un umbral distinto. Desde la rebanada 1, el correlador además **sitúa antes de medir** y responde sus ventanas desde lo ya observado en vez de volver al bus.

El recorrido por el código está en `docs/como-funciona-el-demostrador.md`, **y se ha quedado corto**: no cuenta la resolución de objeto ni el submódulo del canon.

**Reunión de seguimiento con Alejandro: el 26-ago-2026**, la primera desde que volvió de vacaciones. Tiene la PR #3 sin revisar —creada a propósito sin pedirle revisión— y la PROP-031, que no es suya (es plano funcional) pero es justo el tipo de tensión que su papel de validación existe para detectar.

## La decisión que estaba abierta: resuelta el 25-ago

De los tres caminos se eligió **el segundo y el tercero, en ese orden y como una sola pieza**: construir `REQ-07-VLC-01` y, con el motor emitiendo de verdad las seis observables, proponer entonces la letra definitiva del contrato. El primero —migrar las instancias— se descartó: el plan de la tanda deja la instancia canónica de REQ-01 y REQ-02 en el lote IV, así que migrar hoy es adivinar lo que José escribirá.

El razonamiento que lo cerró, para no volver a derivarlo: los caminos 2 y 3 son el mismo trabajo visto desde el canon y desde el código, porque construir la noche de la nave **obliga** a emitir las seis observables. Y el orden está forzado al revés de como parecía: proponer la letra sin haber ejecutado sería proponer serialización para observables que nunca hemos emitido, que es la trampa de la PROP-012.

## Lo que se construyó el 25-ago (rebanada 1 de 3)

**PR #3 de `jolmedilla/indramind-demostrador`**, rama `la-puerta-de-entrada-del-objeto-unico`, tres commits, **abierta y sin pedir revisión a propósito**.

Lo que resuelve: hasta ahora la ley del objeto único se cumplía **por un atajo** —los eventos llegaban con la entidad puesta—. La noche de la nave son siete eventos que no dicen de qué hablan, y el hecho del mundo hay que deducirlo. Entra `motor/resolucion.py` (fusión por espacio y tiempo cuando los círculos de error se tocan; nadie inventa un radio, lo ponen las fuentes al declarar su incertidumbre) y `motor/geo.py` (la función de catálogo `distancia_geo`).

Nace el **objeto**, que no es una detección: es lo que hay antes de que ninguna doctrina opine, y se expone en el expediente con su línea temporal porque sin él la ley del objeto único no es verificable desde fuera.

**El canon entra como submódulo del demostrador**, fijado en `caf59b4`. No es copia sino puntero: los segmentos son fixtures y si la cinta cambia, el replay deja de ser el mismo replay. Los dos repos tienen ahora su propio puntero al canon, y eso es correcto, no una duplicación que arreglar.

Cobertura: la aserción **(a)** del contrato canónico, asertada un peldaño por debajo —sobre el objeto, no sobre la detección—. Declarada en el fichero e impresa en cada ejecución. **Faltan (b) a (e)**: clase y reclasificación, el segundo pack y sus despertares de profundidad uno, las consultas q1/q2 con resultado literal citado, y la pizarra final contra `pizarra-DET-4471.yaml`.

## La PROP-031, en la bandeja desde el 25-ago

**ADR-008 manda repartir el bus por entidad; C-03 dice que la entidad la calcula la máquina correlacionando.** Para las fuentes que informan de un punto y no de un objeto —una llamada al 112—, la clave no existe cuando hay que elegir partición. Con el bus en memoria no se nota; con Kafka, dos particiones son dos procesos que no se conocen y cada uno forma su detección del mismo fuego: **INV-11 se rompe por debajo de toda doctrina**.

Propone la opción C de tres: enunciar la obligación **por su propiedad y no por su mecanismo** —el transporte no separa antes de correlacionar—, dejando la clave libre donde la entidad no viaja en el evento, con la única condición de que sea conservadora. No toca el ADR-008, no elige mecanismo, no añade fila del banco.

El argumento es **interno al canon** y se verifica sin salir de él; nuestras cifras van declaradas aparte. Si José la acepta, nace el ADR-063 y **entonces** se puede proponer el par de garantía, que sería la PROP-032. Antes no: un par de garantía necesita una promesa escrita contra la que la variante infractora falle, y esa promesa hoy no existe.

## El orden de trabajo decidido, y por qué

**Antes de las rebanadas 2 y 3 va la higiene de H1**, pero no la que estaba anotada.

1. **Sacar la doctrina de `dominio.py`.** Los grados están escritos a mano en Python —`0.82`, `0.10`, `0.91`, `0.12`— y los motivos de descarte son cadenas literales; solo los priores vienen del pack. También `politica.py` (`EXPLICACIONES_QUE_NO_INTERRUMPEN` cableado) y el nombre de hipótesis de `DetectorUmbral`. Contradice que la doctrina sea configuración (ADR-022) y **destruye el argumento que vendemos**: la ablación se defiende diciendo «P0 y P1 no son el mismo código con otro umbral», y quien abra el fichero encuentra números a mano.
2. **Renombrar `REF` → `VLC`** en nuestras instancias. Vamos por delante del canon: el token de hoy es `VLC` y `REF` llega cuando la ciudad se generalice. Es gratis.
3. **Dos propuestas antes del lote IV** (ver la sección siguiente).
4. **Rebanadas 2 y 3** de la nave, y después el contrato de observables.

**La deuda del runner como frontera de proceso queda retirada, y conviene no volver a plantearla como estaba.** `src/README.md` la justifica citando POC-005 —«el día que tenga que examinar una implementación ajena»—, pero **POC-007 retiró esa premisa**: el arnés es construcción y queda fuera del canon, y *el runner es de cada línea*. Ninguna línea examina la implementación de otra. Lo que hace comparables a las líneas no es un arnés común sino el **banco** (mismas instancias) y el **contrato de observables** (mismas emisiones). O sea que el sucesor legítimo de esa deuda es el camino 3, que ya está en el plan.

## Qué pasa con REQ-01-REF-01, REQ-02-REF-01 y el pack

**Los ficheros se quedan donde están y hoy no hay que mover nada por nuestra cuenta.** Nuestros YAML son la transcripción ejecutable para nuestro arnés, y el esquema concreto de instancia es **decisión de construcción declarada pendiente** en el `README` de `/banco`. Ya vivieron en el canon una vez —commit `4f3a72c`, 14-ago— y se revirtieron el mismo día en `5145c88`.

Pero hay dos cosas que **sí** son del canon y que hoy solo existen en nuestro repo:

- **El pack `aglomeraciones-valencia.yaml`.** POC-007, punto 5, es explícito: «los insumos compartidos — banco, packs, cintas, esquemas — se producen una sola vez, **en el canon**, porque el contraste solo es válido con entrada idéntica». Y ADR-050 pone «la doctrina de los packs» en el plano funcional, o sea de José. Hoy `/packs` está vacío en el canon y su esquema normativo es pendiente declarado, así que no estamos infringiendo nada; pero **una segunda línea de construcción no podría montar REQ-01**, porque la doctrina no existe donde POC-007 dice que tiene que existir.
- **Las escenas de REQ-01 y REQ-02 con nuestros números ejecutados.** El plan de la tanda ya trae la escena de REQ-01 escrita por José —jueves 18:40, detección a las 18:47, P0 a las 19:12, antelación de 25 minutos— y **no coincide con la nuestra** (18:05 con razonador, 18:35 sin él, 35 y 5 minutos). Las escribió sin nuestra ejecución delante.

**Y aquí la objeción que las mató antes ya no vale.** En la PROP-012 José quitó nuestros 35 y 5 minutos «porque verificó que `/src` estaba vacío en el canon y no eran comprobables desde donde él miraba». Con la PR #3 publicada y el demostrador compartido con él, **ahora sí son comprobables**. Es el momento de meterlos, y el aviso de método es literal: una propuesta que no entra en la bandeja no existe, y el índice del entregable se quedó trece días en los cuadernos mientras José hacía su propia edición.

Las dos van como **propuestas separadas** por la regla de atomicidad, y van **antes del lote IV**, porque una vez José escriba las instancias normativas cambiarlas cuesta mucho más.

## El compromiso, con su letra exacta

**Firme:** H1 en verde con sus ablaciones, y **H2 hasta donde llegue**, para **mediados de septiembre**.

- **H1** = el razonador de dominio en verde: detección anticipada por convergencia (REQ-01) y el espejo de la mascletà (REQ-02), cada uno con su ablación.
- **H2** = el razonador de incidente: ante una detección, proponer misiones dentro del presupuesto de latencia (PRE-02, ~60 s).

**No firme:** lo de H4 a finales de octubre fue una **horquilla** que José pidió expresamente sin compromiso —«sin compromiso, es por saber»; «no necesito que sea octubre escrito en piedra, pero que no sea enero»—. **Queda pendiente rehacer la estimación con fundamento y actualizarle.**

## El hilo del product owner

Abierto por José en la reunión del 19-ago. Habló con **Marcelo**. Hay una **posición de product owner quedando vacante**; si Paradigma no la pone, la pondrían ellos, y «tú serías ahí un candidato claro, y serías un candidato claro cuanto más cerca estés ahora de algo parecido a lo que queremos». Calendario: decisiones **hacia el 15 de septiembre**, presentación a **finales de octubre**, y después «eso desencadena el que te hagan una oferta para entrar».

Ofreció una persona para la parte visual. Aparcado: primero trazas, y algo presentable para finales de octubre.

## Cosas de método que ya costaron caro

**Una propuesta que no entra en la bandeja no existe.** El índice del entregable se quedó trece días en los cuadernos y José hizo su propia edición mientras tanto. Se propone el mismo día que se piensa.

**«Lo hablo con X» es una pausa, no un visto bueno.** El 12-ago se dio por bueno un reparto que Alejandro había pedido pausar, y hubo que revertir `main` del canon.

**No citar como hecho lo que el lector no pueda verificar** en el repositorio que tiene delante.

## La regla de precedencia (sigue vigente)

**El canon de José es base de trabajo y vocabulario común, NO una autoridad ante la que nuestro análisis se retire.** De sus palabras del 29 y 31-jul: «por lo menos yo le aporto poco»; «me lo diga alguien que no tenga un interés en torpedear el tema».

## Conceptos ya establecidos, para no re-derivarlos

- **El «motor cognitivo» es el producto entero**, no la parte determinista ni un componente (ADR-035).
- **Dos ejes ortogonales:** el normativo (motor = obliga · construcción = libre) y el arquitectónico (determinista · generativo). El segundo vive **dentro** del primero.
- **La arquitectura no está impuesta: está implicada.** Seis normas la fuerzan sin describirla — INV-05, INV-04, INV-10, AR-03, PRE-04 y PRE-05.
- **«No hay inviabilidad sin identificador»** nada tiene que ver con el prefijo INV: es que no se puede alegar que algo no se puede hacer sin citar una fila, un invariante o un presupuesto concreto, y se resuelve con evidencia sobre el banco.
- **Tres niveles:** la **norma** → la **fila del banco** (REQ-nn, prosa genérica) → la **instancia** (`REQ-xx-VLC-nn`). Encima, las **suites**: listas versionadas por uso. **El uso vive en la suite, no en el identificador.**
- **Banco vs arnés:** el banco son las preguntas del examen; el arnés es el examinador. «El arnés interpreta las instancias; el motor jamás las lee». **Las tres propiedades del arnés ya son letra normativa del maestro** desde la PROP-015: solo puerta delantera, el arnés es dueño del reloj de tiempo de evento, y el expediente es la única superficie de aserción.
