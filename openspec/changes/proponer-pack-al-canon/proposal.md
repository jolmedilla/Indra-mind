## Why

El pack `aglomeraciones-valencia` es **doctrina de razonamiento**, y la doctrina
de los packs es materia del plano funcional, que ratifica José (ADR-050). Hoy
existe **solo en nuestro repositorio de construcción**.

POC-007, punto 5, no deja margen:

> los insumos compartidos — banco, **packs**, cintas, esquemas — se producen una
> sola vez, **en el canon**, porque el contraste solo es válido con entrada
> idéntica

La consecuencia práctica es concreta y no teórica: **una segunda línea de
construcción no podría montar REQ-01**, porque la doctrina de aglomeraciones no
existe donde POC-007 dice que tiene que existir. Y el modelo entero de POC-007
—N líneas independientes contra el mismo contrato— depende de que pueda haber
una segunda línea.

No estamos infringiendo nada hoy: `/packs` está vacío en el canon y su esquema
normativo es pendiente declarado. Pero el hueco es nuestro de señalar, porque
somos los únicos que tenemos un pack que un motor ejecuta de verdad.

Y hay una ventana: el **lote IV** del plan de la tanda asignará instancias a las
filas obligatorias, REQ-01 y REQ-02 entre ellas. Después, cambiar cuesta más.

## What Changes

Se redacta y se da de alta una propuesta en la bandeja del canon —`PROP-032` o
el número libre que toque— que ofrece el pack como candidato al `/packs` del
canon, con su texto literal.

La propuesta **no decide el esquema normativo de `/packs`**, que es pendiente
declarado: ofrece un pack real y ejecutado como insumo de esa decisión, que es
justo lo que el `README` de `/banco` pide para las decisiones de construcción
pendientes.

## Capabilities

### New Capabilities

Ninguna aquí: lo que se produce es un documento en la bandeja del canon.

### Modified Capabilities

Ninguna.

## Impact

`indramind-poc/propuestas/1-pendientes/` y la fila del inventario de su `README`.

Nada del demostrador, y **nada de `/docs` del canon**: una propuesta es inerte
hasta su veredicto.
