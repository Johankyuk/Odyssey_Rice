# dGPU: apagado, scripts y mediciones

Estado vigente consolidado el 2026-10-28 desde tres capas fechadas. El contexto principal y los pendientes están en AGENTS.md.

## Decisión y estado
- Decisión de Kyu: quedarse en híbrido (dgpu_disable=0) para jugar con la NVIDIA, por encima de la autonomía. Instalados: prime-run, steam, gamemoderun, mangohud, lutris.
- Objetivo de Kyu: un modo GPU on/off general, para pasárselo a nobody e integrarlo en una release anual de Odyssey.
- Equipo: Q-PC (ASUS), driver NVIDIA 595.112.07.
- Interruptor: /sys/devices/platform/asus-nb-wmi/dgpu_disable (0 = dGPU activa, 1 = apagada). gpu_mux_mode=1 (híbrido); egpu_enable no existe. Con 1 la NVIDIA desaparece de lspci y el valor persistió tras reiniciar (uptime 2 min, verificado).

## Verificado con salida real
- dgpu-on en caliente funciona: la NVIDIA (RTX 4050 Max-Q, 01:00.0 y 01:00.1) vuelve al bus, el driver carga, nvidia-smi -L la ve y su runtime queda en suspended. Offload GL (glxinfo renderer NVIDIA) y Vulkan (lista NVIDIA y Radeon 740M RADV) funcionan.
- Al reaparecer, la numeración DRM se invierte: la NVIDIA pasa a card1/renderD129 y la iGPU a card0/renderD128. Usar /dev/dri/by-path y no cardN fijos.
- El apagado en caliente no es posible: elogind-daemon mantiene abiertos los nodos DRM de la NVIDIA y bloquea el rmmod de nvidia_drm (no se sabe por qué los abre). niri no es el cliente.
- El Xorg de SDDM abre la NVIDIA al arrancar (OutputClass de 10-nvidia-drm-outputclass.conf) y bloquea el rmmod; por eso dgpu-off detiene SDDM. zen (RDD Process) también la usa.
- Diseño resultante: encender en caliente; apagar requiere cerrar sesión (un solo comando, vuelve al login).
- Mediciones en batería (30 s, current_now x voltage_now; BAT1 no expone power_now): dGPU encendida y sin clientes (añadida en caliente, SDDM reiniciado sin NVIDIA): 0 ms activa de 30 000, runtime suspended, 7.54 W. dGPU apagada en reposo: 9.52 W. NO son comparables: el brillo y las apps no se controlaron.

## Scripts (~/.local/bin, versionados en el repo)
- dgpu-on: dgpu_disable=0, rescan PCI, modprobe nvidia.
- dgpu-off (v2): desde niri se relanza como root con setsid, detiene SDDM, descarga nvidia_*, pone dgpu_disable=1 y reinicia SDDM (trap EXIT garantiza el reinicio); log en ~/dgpu.log. Probado: el proceso desacoplado sobrevivió al cierre de sesión; resultado dgpu_disable=1, NVIDIA en PCI 0, sddm reiniciado. Cierra la sesión.
- gpu-mode: escribe dgpu_disable y gpu_mux_mode vía asus-nb-wmi (integrated, hybrid, ultimate). El modo ultimate no está probado. Modo elegido: híbrido.

## Sin confirmar (no tratar como hecho)
- Estado de arranque (Xorg de SDDM con la NVIDIA abierta): 57 422 ms activa de 60 000 (95.7 %, una sola medición). En esa medición la pila mostró el Notify ACPI 0xC0 del dispositivo NVPCF (Dynamic Boost) cada ~22.5 s, en pares separados 0.7 s (rm_acpi_nvpcf_notify > os_ref_dynamic_power > rpm_resume), igual con cargador o batería y con perfil performance o balanced; en nv-acpi.c y osapi.c no se encontró parámetro de módulo. La conclusión "la causa es NVPCF" NO está confirmada.
- Hipótesis: en el estado de arranque el Xorg de SDDM mantiene abierta la NVIDIA e impide el suspend. Falta medir tras reiniciar con dgpu_disable=0. Ideas: enmascarar 10-nvidia-drm-outputclass.conf en /etc/X11/xorg.conf.d/ o usar un greeter Wayland; AutoAddGPU=false ya se probó y no bastó. No afecta a los juegos.
- No proponer el parche DSDT hasta repetir la medición en estado de arranque.

## Pendientes dGPU
- Medir en estado de arranque con dgpu_disable=0 y con las mismas condiciones de brillo y apps.
- Generalizar: hoy solo ASUS vía asus-nb-wmi; otros fabricantes usan otros mecanismos.
- Reporte aparte para nobody con los datos de NVPCF y el flujo (separado del post del brillo).
