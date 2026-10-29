# Contexto para agentes de IA (leer primero)

Repo privado de dotfiles de Kyu (Johan Kyu Kim Espinosa), gestionado con chezmoi. Varios agentes de IA colaboran aquí sin compartir memoria: este archivo y CHANGELOG.md son el contexto compartido.

<!-- pendientes-actuales-2026-10-28 -->
## Pendientes actuales (2026-10-28 noche; manda sobre las listas de pendientes más abajo)
- Panel NVIDIA y Flatpak (2026-10-28 noche): sin publicar nada hasta agotar las pruebas (decisión de Kyu). Estado: Sober corre en la NVIDIA con override; mcpelauncher se quedó en la Radeon. Faltan: modeset=1 con odyssey-nvidia --displays-on (reinicio e initramfs; no hacerlo sin avisar), si supertuxkart corre en Wayland o X11 (xlsclients no está instalado), qué GPU usa Bazaar y comprobar en la VM que system-restore.sh aplique el override de Sober. Detalle en docs/flatpak-nvidia.md.
- Foro (nobody): el post del hallazgo del brillo está completo, en borrador, en docs/foro-post-brillo.md. El brillo persistió tras un reinicio (Kyu dijo "si jaló"). Falta que Kyu elija la categoría del foro, confirme los datos marcados en esa sección y publique.
- dGPU en reposo: sospecha sin probar de que el Xorg de SDDM mantiene abierta la NVIDIA (29 131 ms activa de 30 000 en una ventana de 30 s). Ideas: enmascarar 10-nvidia-drm-outputclass.conf en /etc/X11/xorg.conf.d/ o usar un greeter Wayland; AutoAddGPU=false ya se probó y no bastó. No afecta a los juegos. Diagnosticar antes de parchar y reportar aparte; los 9.52 W (apagada) y 7.54 W (encendida) no son comparables.
- Reinstalación: probar el flujo completo (restore.sh, README, system-restore.sh) en una VM de Odyssey o con un usuario nuevo. Es lo menos verificado del repo. Verificar también el orden de carga de zz-kyu-ui.toml frente a odyssey.toml (29 claves se repiten y no se compararon sus valores). Confirmar también que restore.sh deje la paleta morada (theme.toml.tmpl y el wallpaper).
- Limpieza sin decidir (no borrar sin que Kyu lo diga): brightness.toml.bak.* y odyssey.toml.bak.* en ~/.config/noctalia (no están en .chezmoiignore), /etc/default/grub.bak.*, ~/asusd-etc.bak.*.tar.gz, varios .bak.* en ~/.local/bin y /etc/udev/rules.d/99-asus-kbd-rgb.rules.
- Kernel 7 y asus-armoury: cambio de GPU mux; ahí se retoma ~/src/asusctl. Hasta entonces el kernel no cambia.
- Backlog: windowrules; plugins de noctalia; IDE de Python (Miniconda + Spyder, el entorno spyder abre bien; detalle en "Pendientes"); plantillas de chezmoi Shipwreck vs Odyssey estable; bug de miri con la 3.ª ventana (upstream, parche abandonado).

## Entorno
- Distro: Odyssey Shipwreck, copia personal de "nobody" que llega cada ~40 días para cazar bugs y probar betas; su config puede divergir de Odyssey estable.
- Objetivo de fondo de Kyu: que lo que investiga sirva a nobody para una release anual de Odyssey; por eso los hallazgos se redactan para el foro y se separa el origen (Odyssey, upstream o config propia). Prioridad actual: jugar con la NVIDIA antes que ahorrar batería (modo híbrido).
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
foot (foot.ini y themes/), niri (config.kdl, noctalia.kdl), noctalia (odyssey.toml, templates.toml, settings.json, palettes, colorschemes, logo), .zshrc y miri (config.toml). Desde 2026-10-28 también: ~/.local/bin/{dgpu-on,dgpu-off,gpu-mode}, noctalia/brightness.toml (dispositivo de brillo), dot_config/noctalia/theme.toml.tmpl, el wallpaper wallhaven-2eqjdy.png (Pictures/Wallpapers) y README.md (guía de reinstalación en 8 pasos). system-restore.sh está en .chezmoiignore. Desde 2026-10-28 también noctalia/zz-kyu-ui.toml (instantánea del estado de la GUI).

## Qué NO va nunca al repo
Secretos o tokens (revisar con grep antes de cada `add`), vesktop, zen, VSCodium, libaccounts-glib, archivos *.bak.*, binarios (miri) y el correo o datos personales en estos documentos. Tampoco /etc/NetworkManager/system-connections/ (contraseñas Wi-Fi en texto plano): no pegarlo ni subirlo.

## Reglas de trabajo con Kyu
- Español neutro, conciso, sin emojis salvo que Kyu los use primero, sin recapitular.
- Cambios como bloques copy-paste ejecutables, idempotentes, con backup previo (cp "$F" "$F.bak.$(date +%s)") y verificación que aborte con mensaje claro si algo no coincide; terminan con `echo "✓ terminado"`.
- Diagnóstico antes de parchar: no asumir rutas ni contenido; pedir un comando de una sola línea y esperar la salida.
- No afirmar que algo funciona sin salida real que lo confirme.
- Decisiones: tomar la más limpia y declararla en una línea; preguntar solo en trade-offs reales; lo crítico y las instrucciones previas van al INICIO del mensaje (marcado "**Crítico:**"), antes de correr cualquier script; las decisiones que Kyu debe tomar van en negrita ("**Decisión tuya:**") solo al final.
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
- fuente (2026-10-28): OpenDyslexicMono:size=11 en foot.ini y font_family = "OpenDyslexic" en ~/.config/noctalia/odyssey.toml, ya subido al repo.

## Discrepancias conocidas
- Paleta de noctalia (resuelta 2026-10-28): colorschemes/Odyssey/Odyssey.json y settings.json de ~/.config/noctalia son formato v4 heredado, y palettes/Odyssey.json es la paleta `custom` de Shipwreck (rojo #e8192c); ninguno decide los colores actuales. Noctalia v5 fusiona los .toml de ~/.config/noctalia/ y luego carga ~/.local/state/noctalia/settings.toml, que gana si repite un ajuste. Las plantillas activas (foot, niri, qt, kcolorscheme) reescriben foot/themes/noctalia y niri/noctalia.kdl cuando cambia la paleta o se ejecuta `noctalia msg templates-apply`. No cambiar `source` ni aplicar plantillas sin asumir que esos dos archivos del repo se regeneran.
- Bug abierto de miri: en modo master, al abrir la 3ra ventana la vista se corre; focus-column-first manual lo corrige. Se probó un parche en src/layout/master.rs (hilo con sleep de 250ms + FocusColumnFirst/FocusWindow) pero no resolvió el bug y es frágil (condición de carrera); se abandonó, no se guardó como .diff.

## Pendientes
- La lista vigente es "Pendientes actuales", al inicio de este archivo. Aquí queda solo el detalle del IDE de Python.
- IDE de Python: Miniconda en ~/.local/share/miniconda3 y entorno conda "spyder" (Python 3.12, conda-forge, --override-channels para evitar los ToS de los canales de Anaconda); abre bien, con warnings de Qt wayland y amdgpu que no bloquean. Decisión: Miniconda + Spyder, sin Jupyter y sin conda init en .zshrc (activación manual por sesión). Kyu no ha cerrado formalmente este tema.

## Historial
Ver CHANGELOG.md (más reciente al final).

## Equipo ASUS TUF A16 (sesión 2026-10-28)
- Equipo: ASUS TUF Gaming A16 FA607NUG (Ryzen 7 7445HS, RTX 4050). Odyssey Shipwreck: base Void, runit, xbps. Kernel 6.12.113_1 (linux-ether). No cambiar el kernel ni proponerlo por ahora (kernel 7 es un pendiente de Kyu para más adelante, ver Pendientes actuales). Modelo verificado con salida real (2026-10-28, /sys/class/dmi/id/product_name): ASUS TUF Gaming A16 FA607NUG_FA607NUG.
- No escribir a mano ppt_* ni nv_* en /sys/devices/platform/asus-nb-wmi/: los ppt_* leen 5 y no se sabe qué acepta el firmware. dgpu_disable y gpu_mux_mode los escriben los scripts dgpu-on, dgpu-off y gpu-mode (ver docs/dgpu.md).

### asusctl y rog-control-center: DESCARTADO (2026-10-28)
- asusctl y rog-control-center 6.5.0 se compilaron en ~/src/asusctl (tag 6.5.0, origin https://github.com/opengamingcollective/asusctl) y se ELIMINARON del sistema el 2026-10-28: binarios, regla udev 99-asusd.rules, .desktop, dbus asusd.conf, icono, metainfo, locales, /etc/sv/asusd con sus enlaces, /etc/asusd y /usr/share/{asusd,rog-gui,asusctl}. También se quitaron las dependencias de build (51 paquetes, 416 MB; pkg-config se quedó). Respaldo de /etc/asusd en ~/asusd-etc.bak.*.tar.gz; la fuente se conserva en ~/src/asusctl.
- Motivo del descarte: con kernel 6.12 solo funcionaban perfiles de plataforma, límite de carga, monitoreo y brillo del teclado. La pestaña GPU y los límites de potencia piden el driver asus-armoury (kernel 6.19 o 7, según la fuente) y asusctl aura daba os error 13 en kbd_rgb_mode.
- Para retomarlo con kernel 7: cd ~/src/asusctl, git fetch --tags, git checkout <tag>, reinstalar las dependencias de build (ya no están), make, sudo make install, borrar las unidades systemd instaladas y recrear /etc/sv/asusd/run (IS_SERVICE=1, exec /usr/bin/asusd) con su enlace en /var/service.

### Teclado RGB (vigente, no depende de asusd)
- Teclado RGB: se controla escribiendo "1 0 R G B 0" en /sys/class/leds/asus::kbd_backlight/kbd_rgb_mode (archivo de solo escritura). Color elegido: 120 20 220, persistido en el bloque kbd-purple de /etc/rc.local (fuera de chezmoi). Los pasteles (ej. 9c75d7) se ven blancos en el teclado; usar colores saturados. No probado tras suspender.
- Siguen en el sistema, inocuos sin asusd: /etc/udev/rules.d/99-asus-kbd-rgb.rules (hace legibles kbd_rgb_mode y kbd_rgb_state) y el bloque kbd-purple de /etc/rc.local, que escribe directo al LED.

## Tema de noctalia y lavat
<!-- zz-kyu-ui-2026-10-28 -->
- Noctalia v5 fusiona los .toml de ~/.config/noctalia/ y después el estado de la GUI (~/.local/state/noctalia/settings.toml), que gana si repite una clave.
- zz-kyu-ui.toml es una instantánea (2026-10-28) de ese estado sin [theme] ni [wallpaper] (esos están en theme.toml): barras default y VandB, dock, pantalla de bloqueo, OSD, widgets y acciones de sesión. En esta máquina el estado sigue ganando, así que el archivo solo importa en una instalación limpia.
- El prefijo zz- busca que cargue después de odyssey.toml. El orden alfabético NO está verificado, y 29 claves se repiten con odyssey.toml sin haber comparado sus valores. Probar en la VM.
- Para refrescar la instantánea: copiar settings.toml sin config_version, [theme] ni [wallpaper], conservar las 3 líneas de comentario del encabezado, validar con tomllib que el resultado sea igual al original recortado y subir con rice-commit.sh. No subir la configuración efectiva completa (883 líneas de valores por defecto que cambian con cada versión de noctalia).
- Tema noctalia: dot_config/noctalia/theme.toml.tmpl con source = "wallpaper" y wallpaper_scheme = "soft"; wallpaper wallhaven-2eqjdy.png versionado en Pictures/Wallpapers del repo.
- lavat: binario en ~/.local/bin/lavat (no está en xbps ni en chezmoi); Kyu lo usa directo, sin alias.

## Documentos por tema (detalle; leer solo si el tema aplica)
- docs/dgpu.md: dGPU (dgpu_disable, scripts dgpu-on, dgpu-off y gpu-mode, mediciones). Tiene capas fechadas: la corrección de las 13:50 manda sobre las conclusiones anteriores.
- docs/brillo.md: brillo del panel, resuelto con nvidia_wmi_ec_backlight y el arranque por defecto.
- docs/flatpak-nvidia.md: Sober, mcpelauncher y el panel Run on NVIDIA.
- docs/foro-post-brillo.md: borrador del post para nobody, sin publicar.
