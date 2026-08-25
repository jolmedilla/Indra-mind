## Why

Rebanada 2 de las tres que cierran `REQ-07-VLC-01`, **la primera instancia de
aceptación común de todas las líneas de construcción** (POC-007). Hoy nuestra
transcripción cubre solo la aserción (a) del contrato canónico, y la aserta un
peldaño por debajo: sobre el objeto del mundo, no sobre la detección.

Lo que falta aquí son las aserciones **(b)** y **(c)**, que son el corazón del
caso:

- **(b)** el pack de incendios despierta con `e1`, y el de mercancías peligrosas
  **no** despierta por ninguna llamada.
- **(c)** el pack de mercancías despierta **exactamente una vez**, por la
  **reclasificación** de la detección a `incendio.declarado` —la clase que su
  doctrina declara leer; la formación previa como `incendio.conato` no lo
  despierta—, y su lectura no despierta nada más: **profundidad uno** (ADR-054).
  La lectura se escribe en la **misma** pizarra, firmada con pack y versión.

El motor no tiene ninguno de esos conceptos. `Deteccion` no tiene clase ni
historial de reclasificaciones; no existen los patrones sobre detección, solo
sobre evento; el montaje enchufa razonadores pero no sabe de packs múltiples
sobre el mismo objeto; y no se registra ni un despertar.

**Y esto no es solo cerrar una instancia.** Las observables 1 y 2 del contrato
de observables del canon —«detecciones con clase y versión de pack» y «registro
de despertares con su disparador»— son exactamente esto. No se puede proponer la
letra de ese contrato sin haberlas emitido.

## What Changes

- La detección gana **clase** e historial de formación y reclasificaciones, con
  la atribución `pack@versión` de cada una.
- Entra la especie de patrón **sobre detección**, además de la de sobre evento,
  con el límite de **profundidad uno**: la lectura de un pack no despierta a otro.
- El montaje sabe cargar **varios packs** sobre el mismo objeto, cada lectura
  firmada.
- Entra el **registro de despertares**: `pack@versión`, especie del patrón, la
  causa concreta que lo despertó, el instante, y si escribió efecto o murió sin él.
- La instancia gana las aserciones (b) y (c) y la métrica de despertares por
  pack: incendios = 7, mercancías = 1, total 8.

## Capabilities

### New Capabilities

- `motor/clase-de-deteccion`: la detección tiene clase vigente, historial de
  formación y reclasificaciones, y atribución `pack@versión` de cada una.
- `motor/despertares`: qué invocó a qué pack, por qué causa, cuándo, y si dejó
  efecto. Es observable del banco, no traza de depuración.
- `motor/patrones-sobre-deteccion`: la especie de patrón que se dispara con la
  formación o reclasificación de una detección, acotada a profundidad uno.
- `motor/packs-multiples`: varios packs sirviendo lecturas al mismo objeto sin
  crear un segundo objeto, cada lectura firmada.

### Modified Capabilities

Ninguna del canon: aquí no se cambia qué debe hacer el motor, se construye.

## Impact

`indramind-demostrador`: `src/motor/` (expediente, ensamblaje, un cargador de
packs nuevo), `src/runner.py` (aserciones nuevas), `banco/instancias/REQ-07-VLC-01.yaml`.

Los dos packs boceto del caso viven en el canon, en
`docs/apoyo/caso-de-referencia/`, y se leen del submódulo. **No se copian.**

Riesgo anotado: el límite de profundidad uno es de ADR-054 y tiene una razón
fuerte detrás —cortar el encadenamiento de reglas, el modo de fallo clásico de
los sistemas expertos—. Implementarlo mal y dejar que las cadenas crezcan sería
romper una defensa deliberada, no un detalle de eficiencia.
