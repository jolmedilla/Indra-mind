## Why

Rebanada 3, la que cierra `REQ-07-VLC-01`. Quedan las aserciones **(d)** y **(e)**.

- **(d)** las hipótesis descartadas se conservan tachadas **con su motivo y su
  consulta citada** (INV-03): `trabajo_autorizado_no_registrado` descartada por
  `q1` (`sem.agenda_eventos → []`) y `humo_de_proceso` por `q2`
  (`sem.actividad_parcela → proceso_nocturno: false`), ambas ejecutadas dentro
  de la cascada del discriminante.
- **(e)** el replay reproduce **la misma pizarra final con idénticos
  despertares**: clase, grado global, línea temporal, dos lecturas firmadas,
  hipótesis con sus estados y grados, la proyección `tiempo_a_afectacion`
  (22 min, banda ±8, horizonte 60), la atención armada **por sus dos vías** con
  sus vencimientos, y la criticidad subida por instalación catalogada a 61 m
  **sin tocar ningún grado** (REQ-47).

De todo eso el motor tiene hoy: una lista plana de detecciones, un discriminante
único cableado a la agenda, y una interrupción con un solo destinatario y sin
vencimiento. No hay consultables como pieza, ni pizarra, ni proyecciones, ni
criticidad separada del grado.

Cerrando esto, **las seis observables del contrato del canon quedan emitidas por
un motor real**, que es la condición para poder escribir su letra definitiva.

## What Changes

- **Consultables** como pieza de primera clase, con identificador de consulta
  (`q1`, `q2`), modo —automática o por válvula de la política de verificación—,
  instante y **resultado literal**, citable desde el motivo de descarte.
- **La pizarra** de un objeto: línea temporal, lecturas con su atribución,
  hipótesis, proyecciones con banda y horizonte, atención y criticidad. Con
  instantáneas comparables entre pasadas.
- **Proyecciones** como observable propio, distinguidas de lo observado (INV-10).
- **La atención** con destinatario, vencimiento y **vía** —umbral de grado, o
  clase al formarse—, y la interrupción con misiones propuestas dentro del
  presupuesto de 60 segundos (REQ-04, PRE-02).
- **Criticidad** separada del grado, que sube por regla declarada sin escribir
  ningún grado (REQ-47, ADR-028).
- El arnés compara la pizarra final contra `pizarra-DET-4471.yaml` del canon.

## Capabilities

### New Capabilities

- `motor/consultables`: consultas trazadas con su modo, su instante y su
  resultado literal, citables como evidencia.
- `motor/pizarra`: el estado completo de un objeto a un instante, comparable
  entre pasadas.
- `motor/proyecciones`: pronóstico con banda e incertidumbre explícitas,
  distinguido de lo observado.
- `motor/atencion`: obligaciones armadas con destinatario, vencimiento y vía, e
  interrupciones entregadas dentro de su presupuesto.
- `motor/criticidad`: la escala que sube por regla declarada sin tocar grados.

### Modified Capabilities

Ninguna del canon.

## Impact

`indramind-demostrador`: `src/motor/` casi entero, `src/runner.py`,
`banco/instancias/REQ-07-VLC-01.yaml`, que perdería su bloque de cobertura
parcial.

Depende de `nave-clase-y-reclasificacion`: la pizarra necesita la clase y las
lecturas firmadas para tener algo que contener.

Aviso: la aserción (e) contiene una **rebanada de H2** —la interrupción con
misiones dentro del presupuesto de 60 s—, así que esta rebanada no es un desvío
del compromiso de septiembre sino parte de él.
