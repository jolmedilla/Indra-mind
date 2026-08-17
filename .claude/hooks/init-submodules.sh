#!/usr/bin/env bash
# Inicializa los submódulos al arrancar la sesión.
#
# Existe para que este repositorio funcione igual en local que en la versión web
# de Claude Code. Un clon nuevo trae `indramind-poc/` vacío —es un submódulo, no
# una carpeta— y sin este paso la sesión empieza sin el canon del cliente
# delante.
#
# Dos decisiones que conviene no deshacer:
#
#   GIT_TERMINAL_PROMPT=0 — el submódulo es un repositorio privado. Sin esto, en
#   un entorno sin credenciales git se quedaría esperando un usuario y una
#   contraseña que nadie va a teclear, y el arranque de la sesión se colgaría.
#
#   El script nunca falla. Si el submódulo no se puede traer, se avisa y se
#   sigue: es preferible una sesión sin el canon a una sesión que no arranca.

set -uo pipefail

raiz="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
cd "$raiz" || exit 0

# Sin git o sin submódulos declarados no hay nada que hacer, y no es un error.
command -v git >/dev/null 2>&1 || exit 0
[ -f .gitmodules ] || exit 0

salida=$(GIT_TERMINAL_PROMPT=0 git submodule update --init --recursive 2>&1)
codigo=$?

if [ $codigo -ne 0 ]; then
	printf '%s' "$(cat <<JSON
{"systemMessage": "No se han podido inicializar los submódulos. El canon del cliente en indramind-poc/ no estará disponible en esta sesión. Detalle: $(printf '%s' "$salida" | tr '\n"' '  ' | tail -c 300)"}
JSON
	)"
fi

exit 0
