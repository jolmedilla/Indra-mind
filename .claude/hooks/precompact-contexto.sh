#!/usr/bin/env bash
# Antes de compactar, vuelve a poner delante lo que no se puede reconstruir.
#
# La compactación resume la conversación y se lleva por delante detalles que
# después se echan de menos. Este hook devuelve como `additionalContext` el
# contenido íntegro de dos ficheros:
#
#   CLAUDE.md — las reglas del repositorio: la frontera con el submódulo, por
#   dónde empezar, qué no puede bajar al repo del cliente. El harness lo carga
#   solo en cada sesión, pero tenerlo presente durante la compactación ayuda a
#   que el resumen no se lleve por delante justo esas reglas.
#
#   docs/memoria/indra-mind-estado-y-siguientes-pasos.md — el punto de
#   continuación. Este es el que de verdad importa: no se carga solo, y su
#   contenido —las citas del cliente, el plan de hitos, lo que todavía no se
#   sabe— costó semanas de acumular y no se reconstruye leyendo el repositorio.
#
# Como el hook de submódulos, nunca falla: si algo no cuadra, calla y sale con
# cero. El arranque de una compactación no es el sitio donde romper una sesión.

set -uo pipefail

raiz="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"

ficheros=(
	"CLAUDE.md"
	"docs/memoria/indra-mind-estado-y-siguientes-pasos.md"
)

# Se concatenan con una cabecera que dice de dónde sale cada uno, para que al
# otro lado de la compactación se sepa qué se está leyendo y dónde vive.
texto=""
for relativo in "${ficheros[@]}"; do
	absoluto="$raiz/$relativo"
	[ -r "$absoluto" ] || continue
	texto+="===== $relativo ====="$'\n\n'
	texto+="$(cat "$absoluto")"$'\n\n'
done

[ -n "$texto" ] || exit 0

# El contenido tiene que viajar como cadena JSON, con sus saltos de línea y sus
# comillas escapados. Se prueba jq y, si no está, python3; si no hay ninguno de
# los dos, se sale sin hacer nada en lugar de emitir un JSON roto.
if command -v jq >/dev/null 2>&1; then
	printf '%s' "$texto" | jq -Rs \
		'{hookSpecificOutput: {hookEventName: "PreCompact", additionalContext: .}}'
elif command -v python3 >/dev/null 2>&1; then
	printf '%s' "$texto" | python3 -c 'import json,sys
print(json.dumps({"hookSpecificOutput": {"hookEventName": "PreCompact", "additionalContext": sys.stdin.read()}}))'
fi

exit 0
