# Contexto para agentes de IA (leer primero)

Repo privado de dotfiles de Kyu (Johan Kyu Kim Espinosa), gestionado con chezmoi. Varios agentes de IA colaboran aquí sin compartir memoria: este archivo y CHANGELOG.md son el contexto compartido.

<!-- pendientes-actuales-2026-10-28 -->
## Pendientes actuales (2026-10-28 noche; manda sobre las listas de pendientes más abajo)
- Foro (nobody): hallazgo del brillo en borrador, en inglés y con la voz de Kyu. El brillo persistió tras un reinicio. Falta que Kyu elija la categoría del foro y lo publique. Origen probable: firmware, kernel o driver NVIDIA, no Odyssey. No incluir cifras de vatios.
- dGPU en reposo: sospecha sin probar de que el Xorg de SDDM mantiene abierta la NVIDIA (29 131 ms activa de 30 000 en una ventana de 30 s). Ideas: enmascarar 10-nvidia-drm-outputclass.conf en /etc/X11/xorg.conf.d/ o usar un greeter Wayland; AutoAddGPU=false ya se probó y no bastó. No afecta a los juegos. Diagnosticar antes de parchar y reportar aparte; los 9.52 W (apagada) y 7.54 W (encendida) no son comparables.
- Reinstalación: probar el flujo completo (restore.sh, README, system-restore.sh) en una VM de Odyssey o con un usuario nuevo. Es lo menos verificado del repo.
- Limpieza sin decidir (no borrar sin que Kyu lo diga): brightness.toml.bak.* y odyssey.toml.bak.* en ~/.config/noctalia (no están en .chezmoiignore), /etc/default/grub.bak.*, ~/asusd-etc.bak.*.tar.gz, varios .bak.* en ~/.local/bin y /etc/udev/rules.d/99-asus-kbd-rgb.rules.
- Cerrado por evidencia, no por confirmación de Kyu: "actualizar el toml de noctalia en el repo". chezmoi status y chezmoi unmanaged salieron limpios y brightness.toml ya estaba subido (commit ad3717d). Si Kyu se refería a otro toml, revisar con chezmoi diff.
- Kernel 7 y asus-armoury: cambio de GPU mux; ahí se retoma ~/src/asusctl. Hasta entonces el kernel no cambia.
- Backlog previo: windowrules; toml de colores de noctalia (discrepancia roja/morada); plugins de noctalia; IDE de Python (Miniconda + Spyder, el entorno spyder abre bien); plantillas de chezmoi Shipwreck vs Odyssey estable; bug de miri con la 3.ª ventana (upstream, parche abandonado).

## Entorno
- Distro: Odyssey Shipwreck, copia personal de "nobody" que llega cada ~40 días para cazar bugs y probar betas; su config puede divergir de Odyssey estable.
- Base Void: gestor xbps, runit (sin systemd: no usar systemctl).
- Sesión: niri + noctalia (shell Quickshell) + foot + zsh. Laptop con dGPU.
- Máquina Q-PC, usuario kyu. Hardware en la sección "Equipo ASUS TUF A16"; kernel 6.12.113_1 y driver NVIDIA 595.112.07. Arranque con GRUB, login con SDDM, niri como paquete niri-odyssey (niri-odyssey-26.04_10) y noctalia v5 configurada en TOML.
- Herramientas locales: chezmoi en ~/.local/bin, miri (layout master sobre niri) compilado con cargo.
- Otros compositores/DE que ofrece la distro (hypr, waybar, rofi, mango, labwc, KDE): vienen con la distro, no se respaldan.

## Cómo funciona el repo
- Source dir: ~/.local/share/chezmoi. Remoto SSH: git@github.com:Johankyuk/Odyssey_Rice.git (privado, rama main).
- `chezmoi re-add` actualiza el repo desde ~/.config; `chezmoi apply` hace lo contrario.
- `.chezmoiignore` excluye backups (*.bak.*), carpetas con sesiones/credenciales y los archivos de documentación.
- restore.sh: restaura todo en otra máquina (instala chezmoi, genera llave SSH, clona, aplica con backup).

## Qué se respalda
foot (foot.ini y themes/), niri (config.kdl, noctalia.kdl), noctalia (odyssey.toml, templates.toml, settings.json, palettes, colorschemes, logo), .zshrc y miri (config.toml). Desde 2026-10-28 también: ~/.local/bin/{dgpu-on,dgpu-off,gpu-mode}, noctalia/brightness.toml (dispositivo de brillo), dot_config/noctalia/theme.toml.tmpl, el wallpaper wallhaven-2eqjdy.png (Pictures/Wallpapers) y README.md (guía de reinstalación en 8 pasos). system-restore.sh está en .chezmoiignore.

## Qué NO va nunca al repo
Secretos o tokens (revisar con grep antes de cada `add`), vesktop, zen, VSCodium, libaccounts-glib, archivos *.bak.*, binarios (miri) y el correo o datos personales en estos documentos. Tampoco /etc/NetworkManager/system-connections/ (contraseñas Wi-Fi en texto plano): no pegarlo ni subirlo.

## Reglas de trabajo con Kyu
- Español neutro, conciso, sin emojis salvo que Kyu los use primero, sin recapitular.
- Cambios como bloques copy-paste ejecutables, idempotentes, con backup previo (cp "$F" "$F.bak.$(date +%s)") y verificación que aborte con mensaje claro si algo no coincide; terminan con `echo "✓ terminado"`.
- Diagnóstico antes de parchar: no asumir rutas ni contenido; pedir un comando de una sola línea y esperar la salida.
- No afirmar que algo funciona sin salida real que lo confirme.
- Decisiones: tomar la más limpia y declararla en una línea; preguntar solo en trade-offs reales; lo crítico va al final, marcado "**Crítico:**" o "**Decisión tuya:**".
- Cada cambio al repo se registra con el alias de zsh `rice "resumen" "por qué / contexto"` (= `./rice-commit.sh ...`): hace `chezmoi re-add`, añade la entrada a CHANGELOG.md, hace el commit y el push. Un archivo nuevo necesita `chezmoi add` antes de que `rice` lo detecte. Ojo: rice-commit.sh ejecuta chezmoi re-add y git add -A, o sea sube TODO lo pendiente; revisar git status antes. El alias rice no se expande en subshell: usar ~/.local/share/chezmoi/rice-commit.sh.
- Al cerrar un tema, actualizar "Pendientes actuales" (al inicio de este archivo) y "Estado actual".
<!-- agentes-reglas-2026-10-28 -->
- Un bloque por mensaje. Diagnósticos en una sola línea con { ...; }. Marcar bloques parecidos con echo "== vN ==" para distinguir las salidas.
- Tras una prueba visual pedir una observación concreta ("cambió de forma clara" o "no hizo nada"); un "se nota más" o "ya jala" no basta.
- Errores ya cometidos, no repetir: encadenar A && B || C (si B termina en un grep sin coincidencias se dispara C aunque todo haya ido bien; usar if/else); globs sin coincidencias en zsh abortan el comando entero (usar (N)); sv status sin sudo no lee el estado; leer archivos de root sin sudo da falsos fallos; no asumir que fuser existe; xbps-query -m imprime nombre-versión (quitar la versión antes de filtrar); usar el día de instalación como corte en find -newermt llena la salida de archivos del instalador; afirmar que un commit no arrastraría cambios pendientes (rice-commit.sh sí los arrastra).

## Estado actual
- foot: prompt de zsh ">" (en .zshrc), alpha=0.9, cursor parpadeante y background=231736 fijados en foot.ini (después del include del tema, que genera noctalia).
- miri: solo config.toml versionado; el binario instalado es stock, compilado desde ~/src/miri sin parches (el parche probado para el bug de la 3ra ventana se descartó, ver Discrepancias conocidas).
- cava y cmatrix instalados con xbps. lavat no está en xbps; instalado manualmente desde https://github.com/AngelJumbo/lavat (clonado en ~/src/lavat, `make install PREFIX=$HOME/.local`) en ~/.local/bin, sin sudo.
- keybinds: Mod+T se queda para `toggle-window-floating`, se eliminó el duplicado Mod+V. `miri-toggle` (script en ~/.local/bin) quedó sin conectar a ningún bind — Mod+M ya alterna master/scroll vía `miri action cycle-focused-workspace-mode` y aplica `focus-column-first` en cada toggle, no solo al entrar a master.
- noctalia (paleta, resuelto 2026-10-28): el morado sale del wallpaper (~/Pictures/Wallpapers/wallhaven-2eqjdy.png), no de Odyssey.json. Lo decide ~/.local/state/noctalia/settings.toml (fuera del repo): `[theme] source = "wallpaper"`, `wallpaper_scheme = "soft"`, plantillas builtin foot, kcolorscheme, niri y qt, y community zen-browser y thunar. Shipwreck trae por defecto `source = "custom"` con la paleta Odyssey (rojo y negro) en ~/.config/noctalia/odyssey.toml.

## Discrepancias conocidas
- Paleta de noctalia (resuelta 2026-10-28): colorschemes/Odyssey/Odyssey.json y settings.json de ~/.config/noctalia son formato v4 heredado, y palettes/Odyssey.json es la paleta `custom` de Shipwreck (rojo #e8192c); ninguno decide los colores actuales. Noctalia v5 fusiona los .toml de ~/.config/noctalia/ y luego carga ~/.local/state/noctalia/settings.toml, que gana si repite un ajuste. Las plantillas activas (foot, niri, qt, kcolorscheme) reescriben foot/themes/noctalia y niri/noctalia.kdl cuando cambia la paleta o se ejecuta `noctalia msg templates-apply`. No cambiar `source` ni aplicar plantillas sin asumir que esos dos archivos del repo se regeneran.
- Bug abierto de miri: en modo master, al abrir la 3ra ventana la vista se corre; focus-column-first manual lo corrige. Se probó un parche en src/layout/master.rs (hilo con sleep de 250ms + FocusColumnFirst/FocusWindow) pero no resolvió el bug y es frágil (condición de carrera); se abandonó, no se guardó como .diff.

## Pendientes
- La lista vigente es "Pendientes actuales", al inicio de este archivo. Aquí queda solo el detalle del backlog antiguo.
- Windowrules; plugins necesarios de noctalia.
- Paleta de noctalia (respaldo resuelto): el repo ya versiona dot_config/noctalia/theme.toml.tmpl (source = "wallpaper", wallpaper_scheme = "soft") y el wallpaper wallhaven-2eqjdy.png. No se versiona ~/.local/state/noctalia/settings.toml (overrides de la app). Falta confirmar que restore.sh deje la paleta morada en una instalación limpia (parte del pendiente de reinstalación).
- Fuente para dislexia (resuelto 2026-10-28): OpenDyslexicMono:size=11 en foot.ini y font_family = "OpenDyslexic" en ~/.config/noctalia/odyssey.toml, ya subido al repo.
- IDE de Python: Miniconda en ~/.local/share/miniconda3 y entorno conda "spyder" (Python 3.12, conda-forge, --override-channels para evitar los ToS de los canales de Anaconda); abre bien, con warnings de Qt wayland y amdgpu que no bloquean. Decisión: Miniconda + Spyder, sin Jupyter y sin conda init en .zshrc (activación manual por sesión). Kyu no ha cerrado formalmente este tema.
- ROG Control Center (dGPU bajo demanda): DESCARTADO el 2026-10-28 junto con asusctl (ver la sección de asusctl). Se retoma con kernel 7 y asus-armoury.
- Plantillas chezmoi para diferencias entre Shipwreck y Odyssey estable; probar restore.sh y el README en otra máquina o en una VM (ver Pendientes actuales).

## Historial
Ver CHANGELOG.md (más reciente al final).

## Equipo ASUS TUF A16 (sesión 2026-10-28)
- Equipo: ASUS TUF Gaming A16 FA607NUG (Ryzen 7 7445HS, RTX 4050). Odyssey Shipwreck: base Void, runit, xbps. Kernel 6.12.113_1 (linux-ether). No cambiar el kernel ni proponerlo por ahora (kernel 7 es un pendiente de Kyu para más adelante, ver Pendientes actuales).
- No escribir a mano ppt_* ni nv_* en /sys/devices/platform/asus-nb-wmi/: los ppt_* leen 5 y no se sabe qué acepta el firmware. dgpu_disable y gpu_mux_mode los escriben los scripts dgpu-on, dgpu-off y gpu-mode (ver secciones dGPU).

### asusctl y rog-control-center: DESCARTADO (2026-10-28)
- asusctl y rog-control-center 6.5.0 se compilaron en ~/src/asusctl (tag 6.5.0, origin https://github.com/opengamingcollective/asusctl) y se ELIMINARON del sistema el 2026-10-28: binarios, regla udev 99-asusd.rules, .desktop, dbus asusd.conf, icono, metainfo, locales, /etc/sv/asusd con sus enlaces, /etc/asusd y /usr/share/{asusd,rog-gui,asusctl}. También se quitaron las dependencias de build (51 paquetes, 416 MB; pkg-config se quedó). Respaldo de /etc/asusd en ~/asusd-etc.bak.*.tar.gz; la fuente se conserva en ~/src/asusctl.
- Motivo del descarte: con kernel 6.12 solo funcionaban perfiles de plataforma, límite de carga, monitoreo y brillo del teclado. La pestaña GPU y los límites de potencia piden el driver asus-armoury (kernel 6.19 o 7, según la fuente) y asusctl aura daba os error 13 en kbd_rgb_mode.
- Para retomarlo con kernel 7: cd ~/src/asusctl, git fetch --tags, git checkout <tag>, reinstalar las dependencias de build (ya no están), make, sudo make install, borrar las unidades systemd instaladas y recrear /etc/sv/asusd/run (IS_SERVICE=1, exec /usr/bin/asusd) con su enlace en /var/service.

### Teclado RGB (vigente, no depende de asusd)
- Teclado RGB: se controla escribiendo "1 0 R G B 0" en /sys/class/leds/asus::kbd_backlight/kbd_rgb_mode (archivo de solo escritura). Color elegido: 120 20 220, persistido en el bloque kbd-purple de /etc/rc.local (fuera de chezmoi). Los pasteles (ej. 9c75d7) se ven blancos en el teclado; usar colores saturados. No probado tras suspender.
- Siguen en el sistema, inocuos sin asusd: /etc/udev/rules.d/99-asus-kbd-rgb.rules (hace legibles kbd_rgb_mode y kbd_rgb_state) y el bloque kbd-purple de /etc/rc.local, que escribe directo al LED.

## Tema de noctalia y lavat
- Tema noctalia: dot_config/noctalia/theme.toml.tmpl con source = "wallpaper" y wallpaper_scheme = "soft"; wallpaper wallhaven-2eqjdy.png versionado en Pictures/Wallpapers del repo.
- lavat: binario en ~/.local/bin/lavat (no está en xbps ni en chezmoi); Kyu lo usa directo, sin alias.

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

<!-- brillo-reinstalacion-2026-10-28 -->
## Brillo del panel (2026-10-28, noche)
- Resuelto con el arranque por defecto, sin acpi_backlight (GRUB_CMDLINE_LINUX_DEFAULT original: quiet resume=UUID=... loglevel=4). Único dispositivo: nvidia_wmi_ec_backlight (type firmware, máx 200), que mueve el panel. Verificado tras reinicio con salida real: cmdline sin acpi_backlight, un solo dispositivo y brightness.toml apuntando a él.
- Causa desconocida: no se sabe qué cambió entre el arranque donde no respondía y el que sí. Hipótesis sin probar: el EC solo responde bien con la dGPU presente desde el arranque (un solo dato; antes, la escritura al mismo dispositivo con la dGPU añadida en caliente no tuvo efecto visible).
- acpi_backlight=native: aparecen amdgpu_bl1 y nvidia_0; escribir en amdgpu_bl1 cambia sysfs pero el panel no responde (por DPCD el panel se atenúa por PWM, no por AUX). acpi_backlight=vendor: no aparece ningún dispositivo y noctalia muestra "Disabled". asusd detenido no cambió el resultado. No usar acpi_backlight; los /etc/default/grub.bak.* sobran.
- ~/.config/noctalia/brightness.toml (backlight_device = "nvidia_wmi_ec_backlight") está en el repo (commit ad3717d). Las teclas de niri (config.kdl, líneas ~400-401) usan brightnessctl --class=backlight sin -d: con un solo dispositivo funcionan, sin cambios. De las teclas Fn Kyu solo dijo "ya cambia el brillo", sin más detalle.
- Observación sin probar (lectura del script): /etc/sv/odyssey-backlight/run restaura el brillo guardado en el primer dispositivo de /sys/class/backlight/*; con native sería amdgpu_bl1. Va en el post del foro para nobody.

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
