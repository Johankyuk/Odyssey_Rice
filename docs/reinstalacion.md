# Reinstalación y sistema

Detalle por tema, movido desde AGENTS.md el 2026-10-28. El contexto principal y los pendientes vigentes están en AGENTS.md.

## Scripts de GPU y reinstalación (2026-10-28, noche)
- README.md (guía de 8 pasos), restore.sh (instala chezmoi, configura git, genera la llave SSH y hace chezmoi apply con backups) y system-restore.sh (agrega kbd-purple a /etc/rc.local con backup y activa power-profiles-daemon; está en .chezmoiignore).
- Probado: chezmoi apply a una carpeta temporal y comparación con el home: 18 archivos, 0 diferencias. Cubre solo dotfiles.
- Sin verificar: el nombre exacto del módulo NVIDIA en el Control Center de Odyssey (solo se vio el CLI odyssey-nvidia); que las apps ai.storyteller.* salgan de Flathub; el flujo completo en instalación limpia (SSH, paquetes, system-restore.sh, build de miri y lavat).
- Odyssey gestiona por su cuenta: odyssey-secure-dns, los odyssey-nvidia-* de /etc/modprobe.d, /etc/odyssey/nvidia-state.json y los paquetes odyssey-*. Para Steam usar odyssey-prime %command% (prime-run viene en el paquete nvidia).
- Rust viene de rustup (~/.cargo/bin); miri y lavat se compilan desde fuente. Flatpaks: Sober, mcpelauncher, ytmdesktop, Bazaar, Scribe, ai.storyteller.{artcraft-launcher,deckcraft,wordcraft}.
- odyssey-backlight y odyssey-gaming-profile aparecen down con normally up: es normal (restauran estado al arrancar y se apagan solos).
- xbps-pkgdb -a reporta hash mismatch en KDE, base-files, runit-void, kitty y odyssey-*. Hipótesis sin comparar con una salida anterior: personalizaciones de Odyssey. Ninguno es de un paquete quitado.
- No subir /etc/NetworkManager/system-connections/ (contraseñas Wi-Fi en texto plano).
- Pendientes: probar la reinstalación en una VM o con un usuario nuevo; arreglo del Xorg de SDDM (enmascarar 10-nvidia-drm-outputclass.conf en /etc/X11/xorg.conf.d/ o greeter Wayland; AutoAddGPU=false no bastó); limpiar los .bak (brightness.toml.bak.* y odyssey.toml.bak.* en ~/.config/noctalia no están en .chezmoiignore).
