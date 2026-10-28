#!/usr/bin/env bash
# Uso: ./rice-commit.sh "resumen corto" "por qué / contexto para otro agente"
set -euo pipefail
[ $# -ge 2 ] || { echo "uso: rice-commit.sh \"resumen\" \"por qué / contexto\""; exit 1; }
cd ~/.local/share/chezmoi
~/.local/bin/chezmoi re-add
git add -A
FILES=$(git diff --cached --name-only)
[ -n "$FILES" ] || { echo "nada que registrar"; exit 0; }
{
  printf '\n## %s — %s\n' "$(date '+%F %H:%M')" "$1"
  printf -- '- Por qué: %s\n- Archivos:\n' "$2"
  printf '%s\n' "$FILES" | sed 's/^/  - /'
} >> CHANGELOG.md
git add CHANGELOG.md
git commit -q -m "$1" -m "Contexto: $2" -m "Archivos:
$FILES"
git push -q origin main
echo "✓ registrado: $1"
