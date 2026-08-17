---
name: indramind-poc-repo-canon
description: "El repo indramind-poc de José: cómo está gobernado (canon, ADRs, propagación) y en qué punto está el trabajo"
metadata: 
  node_type: memory
  type: project
  originSessionId: 6e2f9326-b8a5-4e21-bcfb-4fd274953309
  modified: 2026-07-31T21:08:44.984Z
---

El repo de José vive **dentro de este repositorio, en `indramind-poc/`, como submódulo de git** (`https://github.com/jruizcristina/indramind-poc.git`, siguiendo la rama `main`). Que sea un submódulo significa que es un repositorio aparte, con su propio historial y su propio gobierno: este repositorio solo guarda un puntero al commit en el que está. Un clon nuevo trae la carpeta vacía hasta que se ejecuta `git submodule update --init`.

Es **la PoC vertical del motor cognitivo sobre el caso de aglomeraciones de Valencia**, y es de José: se rige por su `CLAUDE.md` y por su canon, no por las reglas de este repositorio. El repositorio que lo contiene son los cuadernos privados de asesoría de Juanjo, y **nada de lo que hay en ellos puede entrar en el submódulo**, que lo leen José y Alejandro. Ver [indra-mind-engagement](indra-mind-engagement.md) y [indra-mind-producto](indra-mind-producto.md).

**Arranque obligado de toda sesión** (lo dice su `CLAUDE.md`): leer `CLAUDE.md` → `docs/indice-del-canon.md` → `docs/decisiones.md`. El índice es el único inventario válido de documentos y versiones.

**Gobierno del repo** (esto es lo no obvio):
- Todo es Markdown. Tres estados por documento: **canónico** (manda y obliga a propagar), **apoyo** (`docs/apoyo/`, se cita pero no manda) y **archivo** (`archivo/`, no citable como fuente).
- ADRs inmutables: nunca se editan; una decisión que cambia se escribe como ADR nuevo que supersede al anterior. `decisiones.md` para producto, `decisiones-poc.md` para la PoC.
- **Matriz de propagación** en el índice: quien versiona un documento aplica su fila en el mismo commit.
- `node tools/check_canon.js` antes de cerrar cualquier sesión que toque `docs/`.
- Una sesión, un commit: la sesión deja el commit hecho pero **no hace push** — las credenciales son de José, y hay que recordárselo a él (push + refresco de la fuente del proyecto claude.ai).
- Enfoque TDD sobre el diseño: `/banco` (escenarios dado→cuando→entonces) es el contrato; `/src` no arranca hasta que banco y packs estén validados en simulación.

**Estado a 31-jul-2026** (último commit `ee0fe75`, 30-jul, «José Ruiz (sesión Cowork)»): requisitos en **v0.4** (banco REQ-01..58, glosario 55 entradas), ADR-001..037, POC-001..005, índice v3.3, consultoría v0.2. **No existen todavía `/banco`, `/packs`, `/sim` ni `/src`.** El siguiente paso declarado en `docs/hoja-de-ruta.md` es la **fase 1: el banco**, que se registrará como **POC-006** (convención de nombres `REQ-xx-VLC-nn`, ablaciones `ABL-nn` con perfiles P0..P3 / «solo cámara» / D1-D2, y el README con los dos «verdes»).

**Riesgo de divergencia:** los documentos de `/Users/juanjo/Code/indra-mind/docs/` son anteriores al canon v0.4 y probablemente usan vocabulario ya retirado — ADR-016 retira «sector/sectorización», ADR-017 reasigna «vista» y «proyección» y retira «pronóstico». Conviene alinearlos antes de reutilizarlos con José.
