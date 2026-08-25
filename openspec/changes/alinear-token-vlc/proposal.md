## Why

Nuestras instancias ejecutables se llaman `REQ-01-REF-01` y `REQ-02-REF-01`, y el
canon dice otra cosa. El `README` de `/banco` de `indramind-poc` fija la
convención (ADR-046, POC-006): el identificador es `REQ-xx-<MUNDO>-nn` y **el
token de hoy es `VLC`**, el València sintético; la migración a `REF` queda
declarada para cuando la ciudad se generalice como ciudad de referencia, y
«sustituye, no acumula».

O sea que vamos por delante del canon: usamos el token del futuro. No rompe
nada hoy porque nadie más ejecuta nuestras instancias, y por eso es barato
arreglarlo ahora. Deja de serlo en cuanto José escriba las instancias
normativas de REQ-01 y REQ-02 en el lote IV del plan de la tanda, porque
entonces habrá dos identificadores distintos para el mismo caso y alguien
tendrá que decidir cuál manda.

La instancia de la nave ya nació bien: `REQ-07-VLC-01`.

## What Changes

- Los dos ficheros de `banco/instancias/` pasan a `REQ-01-VLC-01.yaml` y
  `REQ-02-VLC-01.yaml`, con su bloque de identidad al día.
- Se actualizan las citas vivas: `README.md`, `src/README.md` y el recorrido por
  el código en este repositorio.
- Se renombra con `git mv` para que el historial siga los ficheros.

## Capabilities

### New Capabilities

Ninguna. Es un renombrado por convención del canon, sin cambio de conducta.

### Modified Capabilities

Ninguna.

## Impact

`indramind-demostrador`: `banco/instancias/`, `README.md`, `src/README.md`.
Este repositorio: `docs/como-funciona-el-demostrador.md`.

Nada del canon. No hace falta propuesta: la convención ya está ratificada y lo
que hacemos es cumplirla.
