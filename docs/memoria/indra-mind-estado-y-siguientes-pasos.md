---
name: indra-mind-estado-y-siguientes-pasos
description: "Punto de continuación del trabajo de IndraMind: estado al 4-sep-2026, tras la reunión que se atascó por no poder explicar lo construido, con el ADR-064 ganado, el alcance triplicado y tres entregables de comunicación por delante"
metadata:
  node_type: memory
  type: project
---

Estado al **4-sep-2026**. Contexto general en [[indra-mind-engagement]]; el canon en [[indramind-poc-repo-canon]]; cómo quiere José que se trabaje en [[instrucciones-jose-proyecto-indramind]]; lo administrativo en [[alta-autonomo-y-contratacion-malt]].

## Lo primero al abrir sesión

**El canon se mueve muy rápido.** Del 19-ago al 4-sep pasó de la PROP-012 a la PROP-046. Hacer `git submodule update --remote indramind-poc` y mirar qué ha entrado **antes de opinar de nada**: lo que aquí se diga puede haber caducado. Y `openspec list`, que es donde vive el plan.

**Y lo segundo, que importa más.** La reunión del 4-sep se atascó no por el contenido sino porque Juanjo **no podía explicar lo construido**: buscando ficheros, confundiendo qué pack era cuál, y afirmando un cambio que no se había hecho. Sus palabras: «no me acuerdo muy bien de las cosas».

La causa es de ritmo, y es corregible: en una semana entraron cinco pull requests, tres propuestas al canon y cuatro módulos nuevos, contra **seis horas semanales**, un examen y un TFM. Se fusionó material sin leerlo a fondo.

**La regla que sale de ahí, y que hay que respetar:** pull requests más pequeñas, y **si Juanjo no puede explicarla, no está terminada**. Producir más rápido de lo que él absorbe le perjudica, porque lo que se juzga a mediados de septiembre no es solo qué hay construido sino si él lo domina.

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

## Estado del canon (`origin/main` = `21bad52`)

Requisitos **v0.5.12** · **ADR-001..065** · **POC-001..015** · el banco con `storytelling-del-demostrador.md`.

Bandeja: pendientes las viejas de método (013, 016, 019, 022, 037), **las dos nuestras (040 y 041)** y las de José (042 a 046, que tuvieron que renumerarse porque las nuestras ya ocupaban 040 y 041 — la materia de la PROP-013, aún pendiente).

## Ganamos el ADR-064, y salió una segunda decisión de él

Nuestra PROP-031 se renumeró a **PROP-033** por colisión, José la **aceptó con cambios el 26-ago** y es el **ADR-064**: «el transporte no separa antes de correlacionar». Su corrección fue buena — pidió abstraerlo de toda construcción — y de su revisión nació la **PROP-036**, hoy **ADR-065**, que **saca Kafka del canon**.

La sesión de aplicación dejó además `banco/borradores/E-reparto-conservador.md`, el borrador del par de garantía. Es capital político de cara al 15 de septiembre y conviene que se mencione: esta línea también aporta al canon, no solo consume.

## El alcance se triplicó el 26-ago

El banco ganó `storytelling-del-demostrador.md`: prólogo, tres actos, epílogo y un gesto en vivo, con una **suite candidata de dieciocho instancias**, **veinticinco filas obligatorias** y **seis instancias con ensayo generativo** (contador sellado en N=6).

**De las dieciocho, una está escrita** (`REQ-07-VLC-01`) y **diecisiete están «por redactar»** — y las escribe el plano funcional, no nosotros. Hay dos caminos críticos y solo uno es nuestro.

El análisis entero está en `docs/alcance-hasta-la-demo.md`: la matriz de qué exige cada instancia, nueve bloques de trabajo ordenados por lo que desbloquean, y tres escenarios de fecha. **Finales de octubre no da para el demostrador entero**; la capa generativa necesita noviembre; la suite completa son unas veintisiete semanas.

## Qué se construyó, y dónde está

`jolmedilla/indramind-demostrador`, `main` en `16eff6e`, con **PR #12 abierta** (el pack en forma de patrones).

- **Hito 1 en verde** con su ablación de tres escalones: P0 umbrales, P1 dominio, P2 dominio más incidente. La cinta es idéntica en los tres y lo único que cambia es qué se monta.
- **Hito 2 arrancado**: el razonador de incidente propone misiones y la interrupción las lleva (REQ-04, REQ-25, PRE-02).
- **La instancia de aceptación común cubre (a), (b), (c)** y la métrica de despertares —siete y una—, con los **dos packs del canon ejecutados, no traducidos**. Faltan (d) y (e).
- Ocho capacidades con spec en `openspec/specs/`, 42 requisitos.

## La PROP-038 se retiró, y la 041 la sustituye

José pidió a su sesión una revisión de la PROP-038 y **tenía razón en todo**: cinco citas al ADR equivocado —una dentro del texto que habría entrado al canon—, el fichero transportaba construcción al canon contra el punto 3 de POC-007, y su forma no expresaba el despertar.

Se retiró y entró la **PROP-041** con las tres cosas corregidas y el pack reescrito en patrones. **Ninguna de las dos tiene veredicto todavía.**

## Lo que hay que corregir en la próxima sesión

En la reunión del 4-sep se dijo que la regla de la distancia se había cambiado a medir «con respecto a las esquinas», y **quedó así en las notas de Granola**. No se cambió: el código mide al primer vértice, da 81,7 metros donde el caso dice 61, y está declarado como simplificación. Apuntado como `distancia-al-borde-del-poligono`, y **no es cosmética**: la aserción (e) aserta la distancia como valor.

## Las dos sesiones de la semana del 7

Convocadas en la reunión del 4-sep, y son el motivo de los tres entregables del plan:

- **José, dos horas, sin código.** Quiere sintaxis de packs, balance generativo frente a determinista, datos, cintas, escenarios y ablaciones, para poder construir él el storytelling de la demo. Dijo algo que baja la tensión: «si te hago algún challenge, que supongo que no, porque al final el repo dice todo lo que yo pienso en este momento».
- **Alejandro, más breve, de código.** Le interesa «el motor, el chasis, cómo asegurar la doctrina y cómo asegurar los invariantes», y **no el formato de entrada**. Y dejó abierta una puerta: si técnicamente algo del canon estorba, «tiene cabida modificar el canon o ampliarlo».

**Deber asignado a Juanjo:** pensar el mecanismo de ablaciones para que funcione igual en dos implementaciones. Hoy no tiene solución, y lo abrimos nosotros al sacar los perfiles del pack.

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
