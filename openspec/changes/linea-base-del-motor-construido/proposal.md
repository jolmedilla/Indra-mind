## Why

OpenSpec entró en este repositorio el 25-ago-2026, con el motor ya construido y
en verde. El árbol de `openspec/specs/` nació vacío, y eso deja a los cambios
futuros sin línea base contra la que declarar deltas: un cambio que modifique la
resolución de objeto no puede decir qué modifica si la resolución de objeto no
está escrita en ninguna parte.

Este cambio **no construye nada**. Documenta retroactivamente lo que las pull
requests #2 a #5 del demostrador ya dejaron funcionando, para que las capacidades
de construcción de esta línea tengan spec y los cambios siguientes puedan
apoyarse en ella.

**Lo que se documenta es construcción, no producto.** Los requisitos del motor
—qué debe hacer y qué debe garantizar— viven en el canon y los ratifica José
(ADR-050). Aquí se escribe **cómo lo hace esta línea**, que es lo que POC-007
deja en manos de cada línea de construcción. Cada requisito cita la norma del
canon que lo obliga, pero ninguno la reescribe.

## What Changes

Se escriben las specs principales de siete capacidades ya construidas y
verificadas, sin tocar una línea de código:

- El contrato de ejecución del arnés, con sus tres propiedades y el aborto por
  versión no coincidente.
- Las semánticas del transporte, incluida la clave de reparto geográfica y su
  avería declarada.
- La resolución de objeto, con sus dos maneras y su regla de fusión.
- La correlación y las observaciones.
- Los perfiles como listas de razonadores, que es lo que hace estructural la
  ablación.
- La doctrina de dominio como contenido del pack.
- El combinador como único sitio donde se escribe un grado.

## Capabilities

### New Capabilities

- `arnes/ejecucion-del-banco`: cómo esta línea ejecuta una instancia y declara verde o rojo.
- `bus/semanticas-del-transporte`: las cinco semánticas de ADR-008 tal como se realizan aquí.
- `motor/resolucion-de-objeto`: de qué hecho del mundo habla cada evento.
- `motor/correlacion`: la observación con su objeto y su distancia a lo normal.
- `motor/razonadores-y-perfiles`: qué se enchufa detrás del correlador y cómo se declara.
- `motor/doctrina-de-dominio`: qué parte del razonamiento vive en el pack y no en el código.
- `motor/grados-de-confianza`: el combinador como único autor de un grado.

### Modified Capabilities

Ninguna: el árbol de specs estaba vacío.

## Impact

Solo `openspec/specs/`. Ningún fichero de código, ninguna instancia, nada del
canon.

Lo que no garantiza: estas specs describen **lo que hay**, no lo que debería
haber. Si algo de lo construido está mal, esto lo consagra como línea base en vez
de corregirlo. Se asume a propósito — una línea base equivocada se corrige con un
cambio, y no tenerla deja a todos los cambios sin suelo.
