## Why

**Es H2, y no estaba en el plan.** Lo acordado con José es H1 en verde con sus
ablaciones **y H2 hasta donde llegue**, para mediados de septiembre. Conviene la
letra exacta, porque las dos mitades no obligan igual: **H1 es un entregable
firme y completo; H2 es un esfuerzo firme sin línea de meta.** Las palabras de
Juanjo el 19-ago fueron «ya veremos hasta dónde llego con H2».

H2 es el razonador de incidente: ante una detección, proponer misiones dentro del
presupuesto de latencia (PRE-02, ~60 s). Hasta hoy el plan de esta línea tenía
cinco cambios y ninguno era este.

El storytelling del canon lo confirma por dos sitios. La escena **III-1**
(`REQ-13-VLC-01`, obligatoria) es «de dos llamadas a misiones propuestas en menos
de un minuto», y aserta REQ-13, REQ-04 y REQ-25. Y la aserción **(e)** de la
instancia cero, que esta línea ya tiene medio construida, exige la interrupción
«con las misiones propuestas dentro del presupuesto de 60 segundos desde e3
(REQ-04/PRE-02)». O sea que una rebanada de H2 vive dentro de `REQ-07-VLC-01`.

Hoy el motor forma detecciones y no propone nada. No hay misiones, ni plantillas,
ni tácticas, ni presupuesto de latencia medido.

## What Changes

- Entra el **razonador de incidente** como razonador montable, que se enchufa
  detrás del correlador junto al de dominio: el perfil P2 del canon es «dominio
  más incidente», y el montaje ya declara listas de razonadores, no una pieza.
- Ante una detección de una clase que la doctrina cubre, **propone misiones** a
  partir de las plantillas y tácticas que el pack declara — nunca asigna por su
  cuenta (INV-01: la máquina prepara y propone, la persona decide).
- La interrupción deja de llevar solo un motivo y **lleva las misiones
  propuestas**, con su plazo medido desde el evento que las provocó.
- El arnés gana la aserción de **presupuesto de latencia**: propuesta dentro de
  PRE-02 contada en tiempo de evento, no de reloj.

## Capabilities

### New Capabilities

- `motor/razonador-de-incidente`: el razonador que, ante una detección, prepara
  y propone misiones sin asignarlas.
- `motor/misiones`: la misión como objeto propuesto, con su plantilla, sus campos
  y su destinatario.
- `arnes/presupuestos-de-latencia`: la medida de PRE-02 sobre tiempo de evento,
  asertable desde el expediente.

### Modified Capabilities

- `motor/razonadores-y-perfiles`: el perfil P2 monta dos razonadores, que es el
  primer uso real de la lista que la tabla de montaje ya admite.
- `motor/politica-de-interrupcion`: la interrupción entregada lleva las misiones.

## Impact

`indramind-demostrador`: `src/motor/` (razonador nuevo, expediente, política),
`packs/` (plantillas y tácticas), `src/runner.py` (aserción de presupuesto).

**No depende de las rebanadas de la nave**, y por eso puede ir en paralelo o
antes: la interrupción con misiones que la aserción (e) exige es la misma pieza,
así que construirla aquí adelanta también `REQ-07-VLC-01`.

Lo que no garantiza: se construye contra la doctrina que esta línea escriba, y
las plantillas y tácticas del caso de aglomeraciones no están en el canon. Si
José las escribe distintas, hay que rehacer la doctrina, no el motor.
