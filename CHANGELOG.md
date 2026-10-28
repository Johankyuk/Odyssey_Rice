# Historial de cambios (más reciente al final)
Cada entrada: fecha, resumen, por qué y archivos. Lo escribe rice-commit.sh.

## 2026-10-27/28 — Historial previo (resumen)
- Primer commit con foot, niri, noctalia y .zshrc; se excluyeron backups y carpetas con sesiones; se revisó que no hubiera secretos.
- Se agregó miri/config.toml y restore.sh.
- Prompt de zsh ">", alpha 0.9, cursor parpadeante y fondo #231736 en foot.ini; cava y cmatrix instalados.

## 2026-10-27 22:50 — Agrega AGENTS.md, README, CHANGELOG y rice-commit.sh
- Por qué: Contexto compartido para que varios agentes de IA sin memoria común entiendan el repo, y bitácora obligatoria por commit
- Archivos:
  - .chezmoiignore
  - AGENTS.md
  - CHANGELOG.md
  - README.md
  - rice-commit.sh

## 2026-10-27 22:52 — Agrega alias rice en .zshrc
- Por qué: Atajo para registrar commits con bitácora sin escribir la ruta completa
- Archivos:
  - dot_zshrc

## 2026-10-27 23:04 — quitar Mod+V duplicado de toggle-window-floating
- Por qué: Mod+T y Mod+V hacían lo mismo, se dejó solo Mod+T
- Archivos:
  - dot_config/niri/config.kdl

## 2026-10-27 23:06 — actualizar AGENTS.md: alias rice, estado de lavat, keybinds resueltos
- Por qué: cerrar pendiente #2 tras el fix de Mod+V/Mod+T
- Archivos:
  - AGENTS.md
  - AGENTS.md.bak.1793163984
