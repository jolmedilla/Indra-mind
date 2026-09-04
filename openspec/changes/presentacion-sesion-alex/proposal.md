## Why

Alejandro hace **seguimiento y validación de la solución**, y pidió una sesión de
código, más breve y en otro momento. Su interés lo dejó claro en la sesión del
4-sep: «estoy intentando abstraerme del formato de entrada todavía, y más en el
motor, el chasis y todo cómo tiene que funcionar… el cómo asegurar la doctrina y
cómo asegurar los invariantes».

O sea: **no le interesa el formato de los ficheros, le interesa si el motor
garantiza lo que dice garantizar.** Y añadió algo que conviene aprovechar: que si
técnicamente hay un impacto que exija cambiar o ampliar el canon, «entiendo que
tiene cabida».

Es la persona que puede encontrar el fallo que nadie ha visto, y para eso hace
falta enseñarle las costuras, no el escaparate.

## What Changes

Un deck técnico, distinto en naturaleza del de José. Aquí el criterio es el
contrario: **cada garantía se enseña con el mecanismo que la sostiene y con la
comprobación que la puede poner en rojo.** Una garantía sin control negativo no
entra.

Y lleva una sección que el otro deck no lleva: **lo que puede estar mal**. Las
simplificaciones declaradas, las deudas dentro del código y los sitios donde el
motor pasa por accidente. Es la parte más útil para él, y la que evita que la
validación se quede en la superficie.

## Capabilities

### New Capabilities

Ninguna.

### Modified Capabilities

Ninguna.

## Impact

Se publica como Artifact, privado.

**Extensión propuesta: 10 diapositivas más 4 de reserva**, y menos texto por
diapositiva que en el de José: aquí manda el código en pantalla y el diagrama, no
la prosa. El razonamiento: la sesión es «más breve» por acuerdo, y con Alejandro
el valor está en abrir el editor, no en pasar láminas. El deck es el índice de por
dónde ir.

Se recomienda tener el repositorio abierto en paralelo y `--traza` preparada: la
demostración de la ablación en tres escalones dura medio minuto y vale más que
cualquier diapositiva.

Lo que no garantiza: si de la sesión sale que algo del canon estorba
técnicamente, eso no lo decide él —es plano funcional— y hay que llevarlo a la
bandeja. Conviene salir de la sesión con esa lista, no con un acuerdo verbal.
