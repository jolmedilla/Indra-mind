## Why

**El problema no es lo construido: es que no se puede explicar.** En la sesión del
4-sep-2026, con Alejandro y José delante, la demostración se atascó buscando
ficheros, confundiendo qué pack era cuál, y con una frase que quedó registrada en
las notas y **no es cierta**: que la regla de la distancia se había cambiado a
medir contra las esquinas. No se cambió; el código mide al primer vértice y está
declarado como simplificación. Las palabras propias del acta lo resumen: «no me
acuerdo muy bien de las cosas».

La causa es de ritmo. En una semana han entrado cinco pull requests, tres
propuestas al canon, un intérprete de patrones, una gramática y un razonador de
incidente, contra una disponibilidad declarada de **seis horas semanales**, un
examen y un TFM. Se ha ido fusionando material sin leerlo a fondo.

**Y lo que se juzga a mediados de septiembre no es solo qué hay construido, sino
si quien lo presenta lo domina.** El hilo del product owner depende de eso.

Hay además dos sesiones convocadas la semana del 7: dos horas con José sobre
sintaxis de packs, balance generativo frente a determinista, datos, cintas,
escenarios y ablaciones —**expresamente sin código**—, y otra más breve de código
con Alejandro.

## What Changes

Un documento en LaTeX, para leer y estudiar antes de esas sesiones. No es la
documentación del repositorio, que ya existe y está al día: es un **recorrido
para dominar**, escrito para una lectura seguida y para poder responder de
memoria.

Dos decisiones de forma que lo gobiernan:

- **Una introducción al canon y su estructura**, primero, porque sin ella el
  resto es una sopa de identificadores. Ahí viven los términos difíciles.
- **En el resto del documento se escribe en llano**, y cada vez que aparece un
  término del canon se remite a la sección de la introducción donde está
  explicado. Nunca se usa un identificador sin decir en la propia frase qué
  exige.

## Capabilities

### New Capabilities

Ninguna. Es un documento de asesoría.

### Modified Capabilities

Ninguna.

## Impact

Solo `docs/` de este repositorio: fuentes LaTeX y el PDF generado. Ni el
demostrador ni el canon.

**Extensión propuesta: entre 25 y 30 páginas**, más una chuleta de dos páginas al
principio. El razonamiento: menos de veinte no cabe la introducción al canon sin
quedarse en titulares, y más de treinta no se lee en un fin de semana con seis
horas disponibles y un TFM encima. La chuleta va delante porque es lo que de
verdad hace falta el martes: **las diez o doce frases que hay que tener en la
punta de la lengua**, cada una con el sitio del documento donde se explica.

Estilo: el mismo que la memoria del TFM —`babel` en español, la paleta verde,
`listings` con su estilo definido, `biblatex` si hace falta citar—, pero con
clase `report` en vez de `book`: es un documento de trabajo, no una tesis.

Lo que no garantiza: un documento no sustituye a haber escrito el código. Ayuda a
recuperar lo que ya se decidió, no a haberlo decidido. Y envejece con el canon,
que se mueve rápido: lleva fecha y commit de referencia en la portada.
