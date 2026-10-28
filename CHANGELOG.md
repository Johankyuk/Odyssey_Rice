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

## 2026-10-27 23:08 — lavat instalado y AGENTS.md actualizado
- Por qué: lavat compilado desde AngelJumbo/lavat e instalado sin sudo en ~/.local/bin, pendiente de lavat cerrado
- Archivos:
  - AGENTS.md
  - AGENTS.md.bak.1793164133

## 2026-10-27 23:11 — documentar abandono del parche de miri en AGENTS.md
- Por qué: parche de focus-column-first vía hilo+sleep no resolvió el bug y es una condición de carrera; se descarta, no se guarda como .diff
- Archivos:
  - AGENTS.md
  - AGENTS.md.bak.1793164236

## 2026-10-27 23:13 — miri recompilado sin el parche descartado
- Por qué: binario vuelto a stock tras confirmar que el parche de la vista no resolvía el bug
- Archivos:
  - AGENTS.md
  - AGENTS.md.bak.1793164389

## 2026-10-27 23:22 — Miniconda instalado, pendiente conda init y entorno Spyder
- Por qué: IDE de Python: se eligió Miniconda + Spyder sin Jupyter; conda ya funcional, falta inicializar shell y crear el entorno
- Archivos:
  - AGENTS.md
  - AGENTS.md.bak.1793164965

## 2026-10-28 01:24 — Documenta la paleta de noctalia en AGENTS.md
- Por qué: El morado sale del wallpaper vía state/settings.toml; se cierra la discrepancia con Odyssey.json y el respaldo de la paleta queda como pendiente
- Archivos:
  - AGENTS.md

## 2026-10-28 04:30 — AGENTS.md: registro de asusctl, teclado, tema y fuentes
- Por qué: Dejar el contexto de la sesión para los agentes de IA
- Archivos:
  - AGENTS.md

## 2026-10-28 04:34 — Fuente OpenDyslexic en foot y noctalia
- Por qué: Accesibilidad para dislexia; noctalia necesita reinicio del proceso para tomarla
- Archivos:
  - dot_config/foot/foot.ini
  - dot_config/noctalia/odyssey.toml

## 2026-10-28 04:34 — Ignora AGENTS.md.bak.* en chezmoi
- Por qué: Los respaldos de AGENTS.md se desplegaban a ~; se mueven fuera del repo
- Archivos:
  - .chezmoiignore
  - AGENTS.md.bak.1793163984
  - AGENTS.md.bak.1793164133
  - AGENTS.md.bak.1793164236
  - AGENTS.md.bak.1793164389
  - AGENTS.md.bak.1793164965

## 2026-10-28 06:08 — dGPU: dgpu_disable, scripts dgpu-off/on y hallazgo NVPCF
- Por qué: documenta el modo integrado y los pendientes para generalizarlo
- Archivos:
  - AGENTS.md

## 2026-10-28 06:15 — dGPU: encendido en caliente y dgpu-off desde niri verificados
- Por qué: registra las pruebas reales del flujo completo y el diseño resultante
- Archivos:
  - AGENTS.md

## 2026-10-28 13:51 — dGPU: corrección de conclusiones y decisión de quedarse en hybrid
- Por qué: la medición posterior contradice la causa NVPCF; se marca sin confirmar
- Archivos:
  - AGENTS.md

## 2026-10-28 14:40 — noctalia: brightness.toml con nvidia_wmi_ec_backlight
- Por qué: El arranque por defecto solo expone ese dispositivo (EC) y es el que mueve el panel; amdgpu_bl1 ya no existe
- Archivos:
  - dot_config/noctalia/brightness.toml
