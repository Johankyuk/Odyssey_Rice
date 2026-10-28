#!/usr/bin/env bash
set -euo pipefail
REPO="git@github.com:Johankyuk/Odyssey_Rice.git"
C="$HOME/.local/bin/chezmoi"
mkdir -p ~/.local/bin ~/.ssh && chmod 700 ~/.ssh
[ -x "$C" ] || sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
git config --global user.name "kyulovesfc"
git config --global user.email "kyulovesfc@protonmail.com"
git config --global init.defaultBranch main
[ -f ~/.ssh/id_ed25519 ] || ssh-keygen -t ed25519 -C "kyulovesfc@protonmail.com" -f ~/.ssh/id_ed25519
until ssh -o StrictHostKeyChecking=accept-new -T git@github.com 2>&1 | grep -q "successfully authenticated"; do
  echo "--- agrega esta llave en GitHub (Settings > SSH and GPG keys) ---"
  cat ~/.ssh/id_ed25519.pub
  read -r -p "Enter cuando la hayas agregada... " _
done
[ -d ~/.local/share/chezmoi/.git ] || "$C" init "$REPO"
"$C" managed -i files -p absolute | while read -r f; do
  [ -e "$f" ] && cp -a "$f" "$f.bak.$(date +%s)"
done || true
"$C" apply
echo "✓ terminado"
