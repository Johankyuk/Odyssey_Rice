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

## 2026-10-28 14:51 — scripts: dgpu-on, dgpu-off y gpu-mode
- Por qué: Respaldo de los scripts de control de la dGPU para que la reinstalación los traiga
- Archivos:
  - dot_local/bin/executable_dgpu-off
  - dot_local/bin/executable_dgpu-on
  - dot_local/bin/executable_gpu-mode

## 2026-10-28 14:57 — README: guia de reinstalacion y system-restore.sh
- Por qué: Reinstalacion en pasos copiar y pegar sin rog-control-center; system-restore.sh cubre rc.local (kbd-purple) y power-profiles-daemon; sin probar de punta a punta
- Archivos:
  - .chezmoiignore
  - README.md
  - system-restore.sh

## 2026-10-28 15:13 — AGENTS.md: asusctl descartado, brillo resuelto, scripts de GPU y reinstalación
- Por qué: El archivo seguía describiendo asusctl como instalado y no tenía el brillo, los scripts de GPU versionados ni system-restore.sh y el README
- Archivos:
  - AGENTS.md

## 2026-10-28 15:22 — AGENTS.md: pendientes actuales al inicio, reglas de trabajo y estructura limpia
- Por qué: Una sola lista vigente de pendientes al inicio, asusctl y teclado RGB separados, marcas históricas en conclusiones de dGPU superadas, reglas con los errores de hoy y secciones de respaldo y entorno al día
- Archivos:
  - AGENTS.md

## 2026-10-28 15:31 — noctalia: instantánea de la GUI como zz-kyu-ui.toml y notas en AGENTS.md
- Por qué: Los cambios de barras, dock, bloqueo y widgets vivían solo en el estado de la GUI, fuera del repo; el prefijo zz- busca que cargue después de odyssey.toml (orden sin verificar)
- Archivos:
  - AGENTS.md
  - dot_config/noctalia/zz-kyu-ui.toml

## 2026-10-28 15:35 — AGENTS.md: borrador del post del foro, reinicio de confirmación y objetivo de fondo
- Por qué: El borrador del post vivía solo en la conversación; también faltaban la verificación tras el reinicio, el objetivo de fondo de Kyu y la nota de que el modelo FA607NUG no está verificado
- Archivos:
  - AGENTS.md

## 2026-10-28 19:57 — Flatpak y NVIDIA: Sober con override, mcpelauncher en la Radeon
- Por qué: Sober renderiza en la NVIDIA por X11 con override de sistema (system-restore.sh lo reaplica); mcpelauncher se traba con la NVIDIA y se deja en la Radeon; modeset=0 de Odyssey queda como hipótesis sin probar
- Archivos:
  - AGENTS.md
  - README.md
  - system-restore.sh

## 2026-10-28 20:44 — AGENTS.md: panel Run on NVIDIA, vkcube en Wayland y estado de Flatpak
- Por qué: Registra lo verificado del panel (caja de comando sobre odyssey-prime), supertuxkart por el panel, vkcube Wayland vs X11, Bazaar con flags de X11 y las pruebas pendientes; corrige la nota de mcpelauncher en el README
- Archivos:
  - AGENTS.md
  - README.md

## 2026-10-28 21:03 — AGENTS.md: detalle por tema movido a docs/
- Por qué: AGENTS.md pesaba ~33 KB y es lo primero que lee cada agente; dgpu, brillo, flatpak-nvidia y el borrador del foro pasan a docs/ sin cambios de contenido
- Archivos:
  - .chezmoiignore
  - AGENTS.md
  - docs/brillo.md
  - docs/dgpu.md
  - docs/flatpak-nvidia.md
  - docs/foro-post-brillo.md

## 2026-10-28 21:07 — AGENTS.md: regla de orden, pendientes fusionados y modelo verificado
- Por qué: Regla de Kyu (crítico al inicio), sin pendientes resueltos duplicados, FA607NUG verificado por DMI y panel CSOT marcado sin respaldo en el borrador del foro
- Archivos:
  - AGENTS.md
  - docs/foro-post-brillo.md

## 2026-10-28 21:09 — docs/dgpu.md consolidado; reinstalación separada en docs/reinstalacion.md
- Por qué: dgpu.md tenía tres capas fechadas que se contradecían y una sección de reinstalación mezclada; ahora hay un estado vigente con verificado y sin confirmar por separado
- Archivos:
  - AGENTS.md
  - docs/dgpu.md
  - docs/reinstalacion.md

## 2026-10-28 21:12 — AGENTS.md: Historial al final, paleta de noctalia reunida y bullet del foro corregido
- Por qué: Orden de secciones: reglas y pendientes arriba, historial al final; las dos viñetas de la paleta pasan a Tema de noctalia; el bullet del foro apuntaba a una sección que ya no existe
- Archivos:
  - AGENTS.md

## 2026-10-28 21:14 — asusctl y teclado RGB movidos a docs/asus.md
- Por qué: Es lo más grande que quedaba en AGENTS.md y asusctl está descartado; el RGB sigue vigente pero no depende de asusd; AGENTS.md conserva datos del equipo, la regla de ppt_*/nv_* y punteros
- Archivos:
  - AGENTS.md
  - docs/asus.md

## 2026-10-28 21:17 — Panel CSOT verificado con niri msg outputs
- Por qué: El borrador del foro marcaba el panel MNG007QX2-1 a 1920x1200 y 144 Hz como sin respaldo; niri lo confirma (144.002 Hz en eDP-1)
- Archivos:
  - AGENTS.md
  - docs/foro-post-brillo.md
