---
name: identidades-de-git-y-github
description: Juanjo tiene dos identidades de GitHub y la de por defecto es la equivocada para este proyecto; cómo comprobarlo antes de usar gh o de commitear
metadata:
  type: feedback
---

Juanjo tiene **dos cuentas de GitHub** en la misma máquina, y la que sale por
defecto es la equivocada para este proyecto.

- **`jolmedilla`** — la buena aquí. Identidad de git `Juan J. Olmedilla Arregui
  <juanjo@olmedilla.com>`, clave de firma `…315B34F3`, en `~/.gitconfig-personal`.
- **`jolmerlyn`** — la de otro cliente. Identidad `Juan Olmedilla
  <jolmedilla@merlyn.org>`, clave `…8B98B490`, y es lo que trae el `~/.gitconfig`
  global. GitHub atribuye a esta cuenta todo commit con ese correo.

**Antes de usar `gh`, comprobar la cuenta activa.** Por defecto suele quedarse en
`jolmerlyn`; el 25-ago-2026 estaba en `jolmedilla` solo porque Juanjo había hecho
`gh auth login` a mano un momento antes.

```sh
gh auth status                                          # ver la activa
gh auth switch --hostname github.com --user jolmedilla  # cambiarla
```

**Los tres repositorios ya llevan la identidad correcta** por `[include] path =
~/.gitconfig-personal` en su `.git/config` (arreglado el 25-ago-2026; los dos
submódulos no lo tenían y caían al global de Merlyn). Si aparece un clon nuevo o
un submódulo nuevo, hay que ponérselo:

```sh
git -C <repo> config --local include.path '~/.gitconfig-personal'
```

**Por qué importa y no es cosmético:** con la identidad de Merlyn, los commits en
el repositorio del cliente salen firmados con la clave GPG de otro cliente y
atribuidos a un usuario que José no conoce. Pasó con los dos commits de la
PROP-031, y hubo que reescribirlos y volver a empujarlos con `--force-with-lease`.

Ver [[indramind-poc-repo-canon]] para lo del push, que sí se puede hacer.
