---
name: indra-mind-estado-y-siguientes-pasos
description: "Punto de continuación del trabajo de IndraMind: estado al 25-ago-2026, con el modelo de líneas de construcción, el contrato de observables como hueco declarado y la decisión de por dónde seguir"
metadata:
  node_type: memory
  type: project
---

Estado al **25-ago-2026**. Contexto general en [indra-mind-engagement](indra-mind-engagement.md); el canon en [indramind-poc-repo-canon](indramind-poc-repo-canon.md); cómo quiere José que se trabaje en [instrucciones-jose-proyecto-indramind](instrucciones-jose-proyecto-indramind.md); lo administrativo en [alta-autonomo-y-contratacion-malt](alta-autonomo-y-contratacion-malt.md).

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

## Estado del canon (`origin/main` = `caf59b4`)

Requisitos **v0.5.11** · **ADR-001..062** · **POC-001..011** · índice **v3.48**.

Bandeja: **pendientes PROP-013, 016, 019 y 022**, ninguna nuestra. `banco/instancias/` tiene la instancia cero y `banco/suites/` la suite del demostrador de València, en v0.1 y **en construcción**: hasta la congelación de septiembre, la suite propone y no obliga.

## Dónde está nuestro código

`jolmedilla/indramind-demostrador`, dos PR abiertas y **ninguna fusionada**, las dos sin revisar por Alejandro:

- **PR #1** — la regla de trabajar con pull requests. Solo toca `CLAUDE.md`.
- **PR #2** — la partición del correlador y el razonador, hecha el 19-ago. El correlador convierte eventos en observaciones y no sabe de dominio; detrás se enchufa un detector, y `P0` y `P1` son **dos clases distintas**, no un umbral distinto: quitar el razonador es dejar de montarlo. Las cuatro ejecuciones dan el mismo resultado que antes.

Las dos ramas salen de `main` y no se pisan. El recorrido por el código está en `docs/como-funciona-el-demostrador.md`, actualizado.

## La decisión que quedó abierta

Tres caminos, y hay que elegir:

1. **Migrar las instancias** a la convención nueva: Markdown, token `VLC`, ablaciones a `ABL-nn` y expectativas fuera de la instancia normativa.
2. **Construir `REQ-07-VLC-01`**, que es la instancia de aceptación común de todas las líneas y que el motor actual no cubre.
3. **Proponer la letra definitiva del contrato de observables**, que es el hueco declarado de la POC-007 y el único que nadie más puede escribir con fundamento.

La recomendación dada fue **leer antes el `README` de `/banco`**, que es ahora el hogar de la convención y del contrato del arnés, y decidir con eso delante. El tercero es el que más posiciona de cara al hilo del product owner.

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
