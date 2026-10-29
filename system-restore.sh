#!/usr/bin/env bash
# Restaura lo que vive fuera del home: color del teclado (rc.local), servicio de energia y override de Sober
set -euo pipefail
if ! grep -q '>>> kbd-purple' /etc/rc.local; then
  sudo cp /etc/rc.local "/etc/rc.local.bak.$(date +%s)"
  sudo tee -a /etc/rc.local >/dev/null <<'EOF'

# >>> kbd-purple
( F=/sys/class/leds/asus::kbd_backlight/kbd_rgb_mode; for i in $(seq 1 30); do [ -e "$F" ] && { echo "1 0 120 20 220 0" > "$F"; break; }; sleep 1; done ) &
# <<< kbd-purple
EOF
fi
grep -q '>>> kbd-purple' /etc/rc.local || { echo "ABORTO: rc.local sin kbd-purple"; exit 1; }
[ -e /var/service/power-profiles-daemon ] || sudo ln -s /etc/sv/power-profiles-daemon /var/service/
[ -e /var/service/power-profiles-daemon ] || { echo "ABORTO: servicio power-profiles-daemon no activado (falta el paquete?)"; exit 1; }
# Sober: render en la NVIDIA por X11 (override de sistema; vive en /var/lib/flatpak/overrides)
sudo flatpak override --system --nosocket=wayland --socket=x11 --env=__NV_PRIME_RENDER_OFFLOAD=1 --env=__GLX_VENDOR_LIBRARY_NAME=nvidia --env=__VK_LAYER_NV_optimus=NVIDIA_only org.vinegarhq.Sober
sudo flatpak override --system --show org.vinegarhq.Sober | grep -q '__NV_PRIME_RENDER_OFFLOAD=1' || { echo "ABORTO: override de Sober no aplicado"; exit 1; }
echo "✓ terminado"
