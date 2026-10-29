# ASUS: asusctl y teclado RGB

Detalle por tema, movido tal cual desde AGENTS.md el 2026-10-28. Los datos del equipo y la regla sobre ppt_* y nv_* siguen en AGENTS.md.

### asusctl y rog-control-center: DESCARTADO (2026-10-28)
- asusctl y rog-control-center 6.5.0 se compilaron en ~/src/asusctl (tag 6.5.0, origin https://github.com/opengamingcollective/asusctl) y se ELIMINARON del sistema el 2026-10-28: binarios, regla udev 99-asusd.rules, .desktop, dbus asusd.conf, icono, metainfo, locales, /etc/sv/asusd con sus enlaces, /etc/asusd y /usr/share/{asusd,rog-gui,asusctl}. También se quitaron las dependencias de build (51 paquetes, 416 MB; pkg-config se quedó). Respaldo de /etc/asusd en ~/asusd-etc.bak.*.tar.gz; la fuente se conserva en ~/src/asusctl.
- Motivo del descarte: con kernel 6.12 solo funcionaban perfiles de plataforma, límite de carga, monitoreo y brillo del teclado. La pestaña GPU y los límites de potencia piden el driver asus-armoury (kernel 6.19 o 7, según la fuente) y asusctl aura daba os error 13 en kbd_rgb_mode.
- Para retomarlo con kernel 7: cd ~/src/asusctl, git fetch --tags, git checkout <tag>, reinstalar las dependencias de build (ya no están), make, sudo make install, borrar las unidades systemd instaladas y recrear /etc/sv/asusd/run (IS_SERVICE=1, exec /usr/bin/asusd) con su enlace en /var/service.

### Teclado RGB (vigente, no depende de asusd)
- Teclado RGB: se controla escribiendo "1 0 R G B 0" en /sys/class/leds/asus::kbd_backlight/kbd_rgb_mode (archivo de solo escritura). Color elegido: 120 20 220, persistido en el bloque kbd-purple de /etc/rc.local (fuera de chezmoi). Los pasteles (ej. 9c75d7) se ven blancos en el teclado; usar colores saturados. No probado tras suspender.
- Siguen en el sistema, inocuos sin asusd: /etc/udev/rules.d/99-asus-kbd-rgb.rules (hace legibles kbd_rgb_mode y kbd_rgb_state) y el bloque kbd-purple de /etc/rc.local, que escribe directo al LED.
