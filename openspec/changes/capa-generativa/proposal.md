## Why

**Es un eje entero que no estaba en el plan y que el canon acaba de hacer
obligatorio.** El `storytelling-del-demostrador.md`, con sus actos ratificados el
26-ago-2026, declara **seis de las dieciocho instancias con ensayo generativo**, y
el plan de la tanda selló su contador en **N = 6**. Esta línea no tiene ni una
línea de capa generativa: todo lo construido es determinista.

Las seis: `REQ-47-VLC-01` y `REQ-50-VLC-01` en el prólogo, `REQ-20-VLC-01` y
`REQ-66-VLC-01` en el acto II, `REQ-49-VLC-01` en el acto III y `REQ-21-VLC-01`
en el gesto en vivo. Cuatro de ellas son **obligatorias**.

Y el contador existe por un motivo declarado que conviene repetir: la capa
generativa **es la única pieza del motor que ya existe como será en producción**,
y su cobertura no puede quedar en cero.

## What Changes

- Entra el **punto único de invocación generativa** (POC-003): todo lo que la
  capa generativa produzca pasa por un solo sitio, que es lo que hace medible el
  presupuesto y auditable la etiqueta.
- Toda salida generativa nace **etiquetada** (INV-10, REQ-37) y **no escribe
  ningún grado de confianza** (INV-04, AR-03, ADR-028): propone contenidos, y los
  grados los sigue calculando el combinador.
- La **forma catalogada** de la invocación —la valoración en dos tiempos, con la
  primera pasada a ciegas (ADR-028)— y la **válvula** que solo se abre por
  cláusula declarada, con su tope (ADR-048).
- El **presupuesto de invocaciones** (PRE-05), medido y asertable.
- Los **anclajes**: lo que la capa generativa afirma cita eventos y consultas que
  existen, y eso se comprueba.
- Salidas generativas **enlatadas o cacheadas** para el replay: sin eso, la doble
  pasada con diferencia cero (INV-05) es imposible.

## Capabilities

### New Capabilities

- `motor/invocacion-generativa`: el punto único por el que pasa toda invocación,
  con su forma catalogada, su válvula y su presupuesto.
- `motor/marcado-de-lo-generado`: la etiqueta de origen y la prohibición de
  escribir grados, verificables desde el expediente.
- `motor/anclajes`: lo afirmado por la capa generativa cita evidencia que existe.
- `arnes/pasada-sin-generativas`: la ejecución con lo generativo desactivado o
  cacheado, que es lo que hace verificable INV-05 y lo que la definition of done
  exige sobre toda la suite (REQ-53).

### Modified Capabilities

- `motor/grados-de-confianza`: el combinador pasa a ser también la defensa
  comprobable de que el modelo no escribe grados.

## Impact

`indramind-demostrador`: `src/motor/` con módulos nuevos, `packs/` con los
momentos y la forma declarados, `src/runner.py` con las aserciones del sobre.

**Depende del contrato de observables** por el lado del «sobre»: el borrador del
canon ya declara qué es aserción determinista sobre una salida generativa —la
invocación ocurre cuando la doctrina dice, la etiqueta presente, los anclajes
citando cosas que existen, cero grados, la válvula con su tope, el presupuesto
respetado—. Esa lista es la especificación de esta capacidad.

Lo que no garantiza, y hay que decirlo: **la «carta» no es observable de arnés**.
Si la valoración es un juicio que un jefe de sala firmaría, eso lo juzga el
responsable del plano funcional en el propio ensayo, no una aserción. Esta
capacidad construye el sobre; la carta se valida a mano.

Y un aviso de coste: esto introduce la primera dependencia externa real —un
modelo—, con lo que trae de latencia, de coste por invocación y de no
determinismo. La pasada cacheada no es una comodidad: es la condición para que el
banco siga siendo ejecutable.
