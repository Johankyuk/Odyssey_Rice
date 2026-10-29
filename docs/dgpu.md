# dGPU: apagado, scripts y mediciones

Detalle por tema, movido tal cual desde AGENTS.md el 2026-10-28. El contexto principal y los pendientes vigentes están en AGENTS.md.

<!-- dgpu-modo-2026-10-28 -->
## dGPU: apagado con dgpu_disable (2026-10-28)

Verificado con salida real en Q-PC (ASUS, driver NVIDIA 595.112.07):
- En modo híbrido la dGPU casi nunca suspende: 57 422 ms activa de 60 000 (95.7 %, una sola medición). SIN CONFIRMAR: ver la corrección al final de la sección dGPU.
- Causa: el driver atiende el Notify ACPI 0xC0 del dispositivo NVPCF (Dynamic Boost) cada ~22.5 s, en pares separados 0.7 s (pila: rm_acpi_nvpcf_notify > os_ref_dynamic_power > rpm_resume). Igual con cargador o batería y con perfil performance o balanced. En nv-acpi.c y osapi.c no se encontró parámetro de módulo para evitarlo.
- Interruptor: /sys/devices/platform/asus-nb-wmi/dgpu_disable (0 = dGPU activa, 1 = apagada). gpu_mux_mode=1 (híbrido); egpu_enable no existe. Con 1 la NVIDIA desaparece de lspci y el valor persistió tras reiniciar (uptime 2 min, verificado).
- Consumo en batería con la dGPU apagada y en reposo: 9.52 W promedio (30 s, current_now x voltage_now; BAT1 no expone power_now). No hay medición comparativa con la dGPU encendida.
- Scripts en ~/.local/bin (versionados en el repo desde 2026-10-28): dgpu-off (desde TTY: sv stop sddm, rmmod nvidia_*, dgpu_disable=1, sv start sddm; log en ~/dgpu.log) y dgpu-on (dgpu_disable=0, rescan PCI, modprobe nvidia; ver actualización abajo).
- El Xorg de SDDM abre la NVIDIA al arrancar (OutputClass de 10-nvidia-drm-outputclass.conf) y bloquea el rmmod; por eso dgpu-off detiene SDDM. zen (RDD Process) también la usa.

Objetivo de Kyu: un modo GPU on/off general, para pasárselo a nobody e integrarlo en una release anual de Odyssey.
[Histórico: dgpu-on en caliente ya quedó verificado más abajo; lo vigente está en 'Pendientes actuales'] Pendientes de entonces: probar dgpu-on en caliente; evitar que el Xorg de SDDM tome la NVIDIA (o greeter Wayland) para alternar sin cerrar sesión; medir consumo comparativo; reporte para nobody con los datos de NVPCF; generalizar (hoy solo ASUS vía asus-nb-wmi).

<!-- dgpu-update-2026-10-28 -->
### dGPU: actualización, flujo completo verificado (2026-10-28 06:14)

- dgpu-on en caliente funciona: la NVIDIA (RTX 4050 Max-Q, 01:00.0 y 01:00.1) vuelve al bus, el driver carga, nvidia-smi -L la ve y su runtime queda en suspended. Offload GL (glxinfo renderer NVIDIA) y Vulkan (lista NVIDIA y Radeon 740M RADV) funcionan.
- Al reaparecer, la numeración DRM se invierte: la NVIDIA pasa a card1/renderD129 y la iGPU a card0/renderD128. Usar /dev/dri/by-path y no cardN fijos.
- El apagado en caliente no es posible: elogind-daemon mantiene abiertos los nodos DRM de la NVIDIA y bloquea el rmmod de nvidia_drm (no se sabe por qué los abre). niri no es el cliente.
- dgpu-off v2: desde niri se relanza como root con setsid, detiene SDDM, descarga nvidia_*, pone dgpu_disable=1 y reinicia SDDM (trap EXIT garantiza el reinicio). Probado: el proceso desacoplado sobrevivió al cierre de sesión; resultado dgpu_disable=1, NVIDIA en PCI 0, sddm reiniciado.
- Diseño resultante: encender en caliente; apagar requiere cerrar sesión (un solo comando, vuelve al login).
- Medido: 9.52 W promedio en batería con la dGPU apagada (reposo, 30 s). Sin medición comparativa con la dGPU encendida.
- [Histórico, ver 'Pendientes actuales'] Pendientes de entonces: medir consumo con la dGPU encendida; generalizar (hoy solo ASUS vía asus-nb-wmi; otros fabricantes usan otros mecanismos); reporte para nobody con los datos de NVPCF y el flujo.

<!-- dgpu-correccion-2026-10-28 -->
### dGPU: corrección a las conclusiones anteriores (2026-10-28 13:50)

- La conclusión "la dGPU casi nunca suspende; la causa es NVPCF" quedó SIN CONFIRMAR. Estado de arranque (Xorg de SDDM con la NVIDIA abierta): 57 422 ms activa de 60 000. Medición posterior, con la dGPU añadida en caliente y sin clientes (SDDM reiniciado sin NVIDIA): 0 ms activa de 30 000, runtime suspended, 7.54 W en batería.
- Los 7.54 W (dGPU encendida) y los 9.52 W (apagada) no son comparables: las condiciones de brillo y apps no se controlaron.
- Hipótesis sin verificar: en el estado de arranque el Xorg de SDDM mantiene abierta la NVIDIA y eso impide el suspend. Falta medir tras reiniciar con dgpu_disable=0.
- Decisión de Kyu: quedarse en hybrid (dgpu_disable=0) para jugar con la NVIDIA, por encima de la autonomía. Instalados: prime-run, steam, gamemoderun, mangohud, lutris.
- No proponer el parche DSDT hasta repetir la medición en estado de arranque.

## Scripts de GPU y reinstalación (2026-10-28, noche)
- dgpu-on, dgpu-off y gpu-mode (~/.local/bin) están versionados. gpu-mode escribe dgpu_disable y gpu_mux_mode vía asus-nb-wmi (integrated/hybrid/ultimate); el modo ultimate no está probado. dgpu-off cierra la sesión. Modo elegido: híbrido (dgpu_disable=0).
- README.md (guía de 8 pasos), restore.sh (instala chezmoi, configura git, genera la llave SSH y hace chezmoi apply con backups) y system-restore.sh (agrega kbd-purple a /etc/rc.local con backup y activa power-profiles-daemon; está en .chezmoiignore).
- Probado: chezmoi apply a una carpeta temporal y comparación con el home: 18 archivos, 0 diferencias. Cubre solo dotfiles.
- Sin verificar: el nombre exacto del módulo NVIDIA en el Control Center de Odyssey (solo se vio el CLI odyssey-nvidia); que las apps ai.storyteller.* salgan de Flathub; el flujo completo en instalación limpia (SSH, paquetes, system-restore.sh, build de miri y lavat).
- Odyssey gestiona por su cuenta: odyssey-secure-dns, los odyssey-nvidia-* de /etc/modprobe.d, /etc/odyssey/nvidia-state.json y los paquetes odyssey-*. Para Steam usar odyssey-prime %command% (prime-run viene en el paquete nvidia).
- Rust viene de rustup (~/.cargo/bin); miri y lavat se compilan desde fuente. Flatpaks: Sober, mcpelauncher, ytmdesktop, Bazaar, Scribe, ai.storyteller.{artcraft-launcher,deckcraft,wordcraft}.
- odyssey-backlight y odyssey-gaming-profile aparecen down con normally up: es normal (restauran estado al arrancar y se apagan solos).
- xbps-pkgdb -a reporta hash mismatch en KDE, base-files, runit-void, kitty y odyssey-*. Hipótesis sin comparar con una salida anterior: personalizaciones de Odyssey. Ninguno es de un paquete quitado.
- No subir /etc/NetworkManager/system-connections/ (contraseñas Wi-Fi en texto plano).
- Pendientes: probar la reinstalación en una VM o con un usuario nuevo; arreglo del Xorg de SDDM (enmascarar 10-nvidia-drm-outputclass.conf en /etc/X11/xorg.conf.d/ o greeter Wayland; AutoAddGPU=false no bastó); limpiar los .bak (brightness.toml.bak.* y odyssey.toml.bak.* en ~/.config/noctalia no están en .chezmoiignore).
