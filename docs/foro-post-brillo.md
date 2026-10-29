# Post del foro para nobody (borrador)

Detalle por tema, movido tal cual desde AGENTS.md el 2026-10-28. El contexto principal y los pendientes vigentes están en AGENTS.md.

<!-- registro-sesion-2026-10-28 -->
## Post del foro para nobody: borrador (2026-10-28, noche)
- Tipo: hallazgo (observación), no bug de Odyssey. Origen probable: firmware, kernel o driver NVIDIA. Va en inglés, en la voz de Kyu: prosa con encabezados en negrita, sin viñetas, humor autocrítico y firma "- Q (Kyu)". Si el agente tiene la skill odyssey-forum-voice, leerla y pasar humanizer; no corregir la gramática no-nativa de Kyu.
- Falta: la categoría del foro (Kyu no la ha dicho) y que Kyu confirme lo marcado abajo. No incluir cifras de vatios (9.52 W y 7.54 W no son comparables y pertenecen al reporte aparte del Xorg de SDDM).
- Por confirmar antes de publicar: el modelo FA607NUG ya quedó verificado (DMI: ASUS TUF Gaming A16 FA607NUG_FA607NUG); el panel CSOT MNG007QX2-1 a 1920x1200 y 144 Hz sale del borrador anterior y no tiene salida que lo respalde (verificar el EDID antes de publicar); la frase sobre amdgpu.backlight=1 viene de un borrador anterior y el handoff no dice que se probara; "It survived a reboot" descansa en un solo reinicio y en el "si jaló" de Kyu; gpu_mux_mode=1 como híbrido viene de la sección dGPU (verificado en esa sesión).
- Errores ya corregidos en el borrador, no repetir: las líneas de dmesg (amdgpu omite su registro; nvidia-modeset dice que ACPI no reportó backlight nativo) son del arranque con acpi_backlight=vendor, no del arranque por defecto; no se afirma que las teclas Fn funcionen (Kyu solo dijo "ya cambia el brillo"); no se afirma que el EC dependa de la dGPU al arrancar (es hipótesis con un solo dato).
- Texto para publicar (la cita es solo formato de este archivo):

> **Panel brightness on the TUF A16 only moves through nvidia_wmi_ec_backlight**
>
> Hello Argonauts, sharing something I spent most of a day on, in case it helps anyone with a hybrid laptop. @nobody maybe it's useful for the next release too.
>
> **What happened**
> For a while the brightness of the internal panel didn't change at all, not with the slider in noctalia and not with the keys. The sysfs values moved, the screen stayed the same. Now it works, but I honestly don't know what fixed it, so I'm posting this as an observation and not as a solved bug.
>
> **My setup**
> ASUS TUF Gaming A16 FA607NUG with a Radeon 740M and an RTX 4050 Max-Q, Odyssey shipwreck, kernel 6.12.113_1, NVIDIA 595.112.07, niri 26.04 and noctalia. Hybrid mode (dgpu_disable=0, gpu_mux_mode=1). The panel is a CSOT MNG007QX2-1, 1920x1200 at 144 Hz (eDP-1).
>
> **What I tried**
> On the default boot there's only one device in /sys/class/backlight, nvidia_wmi_ec_backlight (type firmware, max 200), and it moves the panel. The slider and the OSD in noctalia work with brightness.toml pointing to it.
>
> With acpi_backlight=native two devices show up, amdgpu_bl1 and nvidia_0. Writing to amdgpu_bl1 changes the sysfs values but the panel doesn't react. I also read the panel's DPCD: it dims through PWM, not through AUX, so the amdgpu.backlight=1 idea was a dead end. I even stopped asusd to be sure it wasn't in the way (I had asusctl installed back then, LOL) and nothing changed.
>
> With acpi_backlight=vendor there's no backlight device at all and noctalia shows "Disabled". In dmesg amdgpu skips its own backlight registration, and nvidia-modeset says ACPI didn't report a native backlight.
>
> Earlier that day I had also written to nvidia_wmi_ec_backlight after turning the dGPU off and back on at runtime. The write was accepted and nothing happened on screen.
>
> **What I think it is**
> My guess, not proven: the EC only drives the panel properly when the NVIDIA GPU is there from boot, not when I bring it back later. That's one data point, so don't quote me. I can't tell what changed between the dead boot and the working one. Not sure if it's the firmware, the kernel or the NVIDIA driver, but I don't think it's Odyssey.
>
> One more thing for @nobody: /etc/sv/odyssey-backlight/run restores the saved brightness into the first device it finds in /sys/class/backlight. On the default boot there's only one so it's fine, but with acpi_backlight=native the first would be amdgpu_bl1, the one that doesn't move the panel. This is only from reading the script, I haven't tested it.
>
> It survived a reboot, and I want to check it again with the dGPU off. The best is yet to come.
> - Q (Kyu)
