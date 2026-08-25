---
name: la-fusion-de-pr-la-decide-juanjo
description: En indramind-demostrador la sesión abre la pull request y para ahí; fusionar y borrar ramas lo hace Juanjo a mano
metadata:
  type: feedback
---

En `indramind-demostrador`, **la sesión abre la pull request y para ahí**. No la
fusiona nunca por su cuenta, aunque el cambio esté en verde, aunque lo haya
escrito ella entera y aunque el banco pase. Tampoco borra ramas del remoto.

**Por qué:** la regla 5 del `CLAUDE.md` de ese repositorio decía «quien construye
fusiona cuando el cambio está listo, sin esperar», y estaba pensada para no
depender del revisor cuando está ocupado o de vacaciones. Leída por una sesión,
autorizaba a fusionar sola, y el 25-ago-2026 pasó cuatro veces seguidas —PR #3,
#4, #5 y #6 entraron en `main` sin que Juanjo tocara nada—. Que no haya que
esperar al revisor significa que **quien construye no depende de él** para
decidir cuándo entra un cambio; no que la decisión la tome la herramienta.

**Cómo aplicarlo:** crear la rama, commitear, empujar, abrir la PR con
`gh pr create`, y terminar ahí diciendo que queda esperando. Nada de
`gh pr merge` ni `git push origin --delete`. Después de que Juanjo fusione, sí
toca actualizar el puntero del submódulo en `indra-mind`, en commit aparte.

La regla vive en el `CLAUDE.md` de **`indra-mind`**, el repositorio privado, y **no**
en el del demostrador. Se intentó ponerla allí (PR #7) y Juanjo la echó atrás: es
cómo se trabaja con la sesión, no política del proyecto, y el demostrador lo leen
el cliente y su equipo. La misma frontera de un solo sentido que impide que los
cuadernos bajen a los submódulos se aplica a las reglas.

Antes de cualquier `gh`, comprobar la cuenta: ver
[[identidades-de-git-y-github]].
