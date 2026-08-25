## Why

**Es el hueco con nuestro nombre.** POC-007 declara que el canon posee el
contenido del banco y **el contrato de observables que toda línea debe poder
emitir para verificar los «entonces»**, y deja su letra definitiva como
**pendiente declarado**. Hoy vive como borrador en
`banco/contrato-observables.md`, nacido de las aserciones que exigió el
recorrido en seco de la instancia cero.

El borrador declara qué no resuelve: «el formato de serialización, el
transporte, la granularidad temporal de las instantáneas, la relación con el
punto único de invocación generativa y el encaje con el esquema concreto de
instancia y el validador `check_banco`».

**Todo eso solo se contesta habiendo ejecutado.** Y esta es la única línea de
construcción que ha ejecutado un banco con un arnés de verdad, así que es lo
único de todo el encargo que nadie más puede escribir con fundamento.

El orden importa y está forzado: las seis observables mínimas del borrador
nacieron de las aserciones de `REQ-07-VLC-01`, y tres de ellas —reclasificaciones
con `pack@versión`, despertares de profundidad uno, instantáneas de pizarra— **no
las hemos emitido nunca**. Proponer hoy la letra sería proponer una serialización
para observables que no hemos producido, que es exactamente la trampa que costó
la ablación en la PROP-012.

De aquí sale además el sucesor legítimo de la vieja deuda del adaptador: que el
expediente pase a ser un **esquema de intercambio** es esto, y no un refactor de
fontanería.

## What Changes

Se redacta y se da de alta en la bandeja del canon la **letra definitiva del
contrato de observables**, con lo que el borrador deja abierto:

- El **formato de serialización** de cada una de las seis observables, con su
  esquema, propuesto desde el que un motor real emite.
- La **granularidad temporal de las instantáneas** de pizarra y qué las hace
  comparables entre pasadas.
- El **encaje con el esquema de instancia** y con el validador `check_banco`.
- Qué queda deliberadamente fuera: el **transporte**, que es construcción y
  libertad de cada línea (ADR-035).

Y en el demostrador, lo que haga falta para que el expediente **sea** ese
esquema y no una estructura interna que se le parece.

## Capabilities

### New Capabilities

- `arnes/expediente-como-esquema`: el expediente serializado conforme al
  contrato, autosuficiente (REQ-40) y única superficie de aserción, con su
  validación.

### Modified Capabilities

- `motor/despertares`: pasa de observable interna a emitida conforme a contrato.
- `motor/pizarra`: ídem, con la granularidad que el contrato fije.

## Impact

`indramind-poc/propuestas/1-pendientes/`, con la letra literal.

`indramind-demostrador`: la serialización del expediente y el runner.

**Depende de las dos rebanadas de la nave.** Sin ellas, tres de las seis
observables serían propuestas a ciegas.

Lo que no garantiza: el contraste solo es real si otra línea lo ejecuta, y hoy
no hay otra línea. Proponemos desde una implementación, y una implementación es
una prueba de existencia, no una prueba de suficiencia. Conviene decirlo dentro
de la propuesta.
