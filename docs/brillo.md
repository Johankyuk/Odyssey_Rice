# Brillo del panel

Detalle por tema, movido tal cual desde AGENTS.md el 2026-10-28. El contexto principal y los pendientes vigentes están en AGENTS.md.

<!-- brillo-reinstalacion-2026-10-28 -->
## Brillo del panel (2026-10-28, noche)
- Resuelto con el arranque por defecto, sin acpi_backlight (GRUB_CMDLINE_LINUX_DEFAULT original: quiet resume=UUID=... loglevel=4). Único dispositivo: nvidia_wmi_ec_backlight (type firmware, máx 200), que mueve el panel. Verificado tras reinicio con salida real: cmdline sin acpi_backlight, un solo dispositivo y brightness.toml apuntando a él.
- Causa desconocida: no se sabe qué cambió entre el arranque donde no respondía y el que sí. Hipótesis sin probar: el EC solo responde bien con la dGPU presente desde el arranque (un solo dato; antes, la escritura al mismo dispositivo con la dGPU añadida en caliente no tuvo efecto visible).
- acpi_backlight=native: aparecen amdgpu_bl1 y nvidia_0; escribir en amdgpu_bl1 cambia sysfs pero el panel no responde (por DPCD el panel se atenúa por PWM, no por AUX). acpi_backlight=vendor: no aparece ningún dispositivo y noctalia muestra "Disabled". asusd detenido no cambió el resultado. No usar acpi_backlight; los /etc/default/grub.bak.* sobran.
- ~/.config/noctalia/brightness.toml (backlight_device = "nvidia_wmi_ec_backlight") está en el repo (commit ad3717d). Las teclas de niri (config.kdl, líneas ~400-401) usan brightnessctl --class=backlight sin -d: con un solo dispositivo funcionan, sin cambios. De las teclas Fn Kyu solo dijo "ya cambia el brillo", sin más detalle.
- Observación sin probar (lectura del script): /etc/sv/odyssey-backlight/run restaura el brillo guardado en el primer dispositivo de /sys/class/backlight/*; con native sería amdgpu_bl1. Va en el post del foro para nobody.
- Reinicio de confirmación (2026-10-28, noche), con salida real: cmdline sin acpi_backlight (BOOT_IMAGE=/vmlinuz-6.12.113_1, nouveau.config=NvGspRm=1 apparmor=1 security=apparmor quiet resume=UUID=... loglevel=4); un solo dispositivo, nvidia_wmi_ec_backlight type=firmware brightness=200/200; brightness.toml con backlight_device = "nvidia_wmi_ec_backlight"; dgpu_disable=0; nvidia-smi 595.112.07. Kyu respondió "si jaló" sin decir qué probó (slider o teclas Fn): para más rigor, pedirle una observación concreta ("cambió de forma clara" o "no hizo nada").
- El volcado de la configuración efectiva de noctalia (lo subió Kyu) muestra [brightness.monitor.eDP-1] con backend = "backlight" y backlight_device = "nvidia_wmi_ec_backlight": noctalia usa ese dispositivo. Ese volcado no se versiona.
