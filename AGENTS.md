# Contexto para agentes de IA (leer primero)

Repo privado de dotfiles de Kyu (Johan Kyu Kim Espinosa), gestionado con chezmoi. Varios agentes de IA colaboran aquí sin compartir memoria: este archivo y CHANGELOG.md son el contexto compartido.

## Entorno
- Distro: Odyssey Shipwreck, copia personal de "nobody" que llega cada ~40 días para cazar bugs y probar betas; su config puede divergir de Odyssey estable.
- Base Void: gestor xbps, runit (sin systemd: no usar systemctl).
- Sesión: niri + noctalia (shell Quickshell) + foot + zsh. Laptop con dGPU.
- Herramientas locales: chezmoi en ~/.local/bin, miri (layout master sobre niri) compilado con cargo.
- Otros compositores/DE que ofrece la distro (hypr, waybar, rofi, mango, labwc, KDE): vienen con la distro, no se respaldan.

## Cómo funciona el repo
- Source dir: ~/.local/share/chezmoi. Remoto SSH: git@github.com:Johankyuk/Odyssey_Rice.git (privado, rama main).
- `chezmoi re-add` actualiza el repo desde ~/.config; `chezmoi apply` hace lo contrario.
- `.chezmoiignore` excluye backups (*.bak.*), carpetas con sesiones/credenciales y los archivos de documentación.
- restore.sh: restaura todo en otra máquina (instala chezmoi, genera llave SSH, clona, aplica con backup).

## Qué se respalda
foot (foot.ini y themes/), niri (config.kdl, noctalia.kdl), noctalia (odyssey.toml, templates.toml, settings.json, palettes, colorschemes, logo), .zshrc y miri (config.toml).

## Qué NO va nunca al repo
Secretos o tokens (revisar con grep antes de cada `add`), vesktop, zen, VSCodium, libaccounts-glib, archivos *.bak.*, binarios (miri) y el correo o datos personales en estos documentos.

## Reglas de trabajo con Kyu
- Español neutro, conciso, sin emojis salvo que Kyu los use primero, sin recapitular.
- Cambios como bloques copy-paste ejecutables, idempotentes, con backup previo (cp "$F" "$F.bak.$(date +%s)") y verificación que aborte con mensaje claro si algo no coincide; terminan con `echo "✓ terminado"`.
- Diagnóstico antes de parchar: no asumir rutas ni contenido; pedir un comando de una sola línea y esperar la salida.
- No afirmar que algo funciona sin salida real que lo confirme.
- Decisiones: tomar la más limpia y declararla en una línea; preguntar solo en trade-offs reales; lo crítico va al final, marcado "Crítico:".
- Cada cambio al repo se registra con el alias de zsh `rice "resumen" "por qué / contexto"` (= `./rice-commit.sh ...`): hace `chezmoi re-add`, añade la entrada a CHANGELOG.md, hace el commit y el push. Un archivo nuevo necesita `chezmoi add` antes de que `rice` lo detecte.
- Al cerrar un tema, actualizar las secciones "Estado actual" y "Pendientes" de este archivo.

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
- Windowrules; plugins necesarios de noctalia.
- Respaldo de la paleta de noctalia: el repo no guarda ni el wallpaper wallhaven-2eqjdy.png ni el bloque `[theme]` del estado, así que restore.sh previsiblemente dejaría la paleta `custom` roja de Shipwreck. Propuesta sin aprobar: un ~/.config/noctalia/theme.toml versionado con `source = "wallpaper"`, `wallpaper_scheme = "soft"` y las plantillas, más el wallpaper en el repo; no versionar state/settings.toml porque la documentación lo trata como overrides de la app.
- Fuente para dislexia: probar, meterla en noctalia y luego subir el toml.
- IDE de Python: Miniconda instalado en ~/.local/share/miniconda3 (conda 26.9.4, sin conda init en .zshrc todavía). Falta: crear el entorno con Spyder, decidir si se corre `conda init` (quedaría versionado en .zshrc) o se activa manual por sesión.
- ROG Control Center (dGPU bajo demanda): revisar compatibilidad, repo extra o compilar.
- Plantillas chezmoi para diferencias entre Shipwreck y Odyssey estable; probar restore.sh en la otra máquina.

## Historial
Ver CHANGELOG.md (más reciente al final).

## ASUS TUF A16 / asusctl (sesión 2026-10-28)
- Equipo: ASUS TUF Gaming A16 FA607NUG (Ryzen 7 7445HS, RTX 4050). Odyssey Shipwreck: base Void, runit, xbps. Kernel 6.12.113_1 (linux-ether). Kyu no quiere cambiar de kernel: no proponerlo.
- asusctl y rog-control-center 6.5.0 no están en xbps: compilados en ~/src/asusctl desde el tag 6.5.0 (origin https://github.com/opengamingcollective/asusctl; el repo de GitLab migró). Instalados con make install en /usr; se borraron las unidades systemd. Dependencias de build: libs -devel de udev, libinput, seat, fontconfig, xkbcommon, wayland, Mesa, freetype, libusb, expat, at-spi2-core, más pkg-config, cmake, clang y gettext (msgfmt).
- Servicio runit: /etc/sv/asusd/run (IS_SERVICE=1, exec /usr/bin/asusd), enlazado en /var/service/asusd. Fuera del respaldo de chezmoi.
- Actualizar: cd ~/src/asusctl, git fetch --tags, git checkout <tag>, make, sudo make install, borrar las unidades systemd instaladas, sudo sv restart asusd.
- Funciona: perfiles de plataforma, límite de carga, monitoreo y brillo del teclado. No funciona: pestaña GPU y límites de potencia (falta el driver asus-armoury, llega con kernel 6.19) y asusctl aura (os error 13 en kbd_rgb_mode).
- No escribir a mano en /sys/devices/platform/asus-nb-wmi/ (dgpu_disable, gpu_mux_mode, ppt_*, nv_*): los ppt_* leen 5 y no se sabe qué acepta el firmware.
- Teclado RGB: se controla escribiendo "1 0 R G B 0" en /sys/class/leds/asus::kbd_backlight/kbd_rgb_mode (archivo de solo escritura). Color elegido: 120 20 220, persistido en el bloque kbd-purple de /etc/rc.local (fuera de chezmoi). Los pasteles (ej. 9c75d7) se ven blancos en el teclado; usar colores saturados. No probado tras suspender.
- Tema noctalia: dot_config/noctalia/theme.toml.tmpl con source = "wallpaper" y wallpaper_scheme = "soft"; wallpaper wallhaven-2eqjdy.png versionado en Pictures/Wallpapers del repo.
- lavat: binario en ~/.local/bin/lavat (no está en xbps ni en chezmoi); Kyu lo usa directo, sin alias.

<!-- dgpu-modo-2026-10-28 -->
## dGPU: apagado con dgpu_disable (2026-10-28)

Verificado con salida real en Q-PC (ASUS, driver NVIDIA 595.112.07):
- En modo híbrido la dGPU casi nunca suspende: 57 422 ms activa de 60 000 (95.7 %, una sola medición).
- Causa: el driver atiende el Notify ACPI 0xC0 del dispositivo NVPCF (Dynamic Boost) cada ~22.5 s, en pares separados 0.7 s (pila: rm_acpi_nvpcf_notify > os_ref_dynamic_power > rpm_resume). Igual con cargador o batería y con perfil performance o balanced. En nv-acpi.c y osapi.c no se encontró parámetro de módulo para evitarlo.
- Interruptor: /sys/devices/platform/asus-nb-wmi/dgpu_disable (0 = dGPU activa, 1 = apagada). gpu_mux_mode=1 (híbrido); egpu_enable no existe. Con 1 la NVIDIA desaparece de lspci y el valor persistió tras reiniciar (uptime 2 min, verificado).
- Consumo en batería con la dGPU apagada y en reposo: 9.52 W promedio (30 s, current_now x voltage_now; BAT1 no expone power_now). No hay medición comparativa con la dGPU encendida.
- Scripts en ~/.local/bin (no versionados): dgpu-off (desde TTY: sv stop sddm, rmmod nvidia_*, dgpu_disable=1, sv start sddm; log en ~/dgpu.log) y dgpu-on (dgpu_disable=0, rescan PCI, modprobe nvidia; SIN PROBAR).
- El Xorg de SDDM abre la NVIDIA al arrancar (OutputClass de 10-nvidia-drm-outputclass.conf) y bloquea el rmmod; por eso dgpu-off detiene SDDM. zen (RDD Process) también la usa.

Objetivo de Kyu: un modo GPU on/off general, para pasárselo a nobody e integrarlo en una release anual de Odyssey.
Pendientes: probar dgpu-on en caliente; evitar que el Xorg de SDDM tome la NVIDIA (o greeter Wayland) para alternar sin cerrar sesión; medir consumo comparativo; reporte para nobody con los datos de NVPCF; generalizar (hoy solo ASUS vía asus-nb-wmi).
