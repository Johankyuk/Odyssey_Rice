# Odyssey_Rice

Dotfiles de Kyu para Odyssey Shipwreck (niri + noctalia + foot + zsh), gestionados con chezmoi. Repo privado.

Agentes de IA: lee AGENTS.md antes de tocar nada y CHANGELOG.md para el historial.

## Reinstalar desde cero

Estado: flujo armado el 2026-10-28 a partir del sistema real; todavia sin probar de punta a punta. Equipo: ASUS con iGPU AMD y RTX 4050, kernel 6.12.113_1 (no se cambia). Todo es copiar y pegar, en orden.

### 1. Sistema base

Instalar Odyssey Shipwreck con el instalador normal (usuario kyu). Despues, ya en el escritorio, reconectar el Wi-Fi a mano (las contrasenas no van en el repo) y actualizar:

    sudo xbps-install -Syu

### 2. Dotfiles

    mkdir -p ~/.ssh && chmod 700 ~/.ssh
    [ -f ~/.ssh/id_ed25519 ] || ssh-keygen -t ed25519 -C "kyulovesfc@protonmail.com" -f ~/.ssh/id_ed25519
    cat ~/.ssh/id_ed25519.pub

Agregar esa llave en GitHub (Settings > SSH and GPG keys) y seguir:

    ssh -o StrictHostKeyChecking=accept-new -T git@github.com
    [ -d ~/.local/share/chezmoi/.git ] || git clone git@github.com:Johankyuk/Odyssey_Rice.git ~/.local/share/chezmoi
    bash ~/.local/share/chezmoi/restore.sh

### 3. NVIDIA

Instalarla con el Control Center de Odyssey (modulo NVIDIA, driver propietario con 32 bits); es el que deja los archivos odyssey-nvidia-* en /etc/modprobe.d. No instalar el paquete nvidia a mano. Verificar:

    odyssey-nvidia --status
    nvidia-smi -L

### 4. Paquetes

    sudo xbps-install -Sy void-repo-multilib void-repo-multilib-nonfree void-repo-nonfree
    sudo xbps-install -Sy steam lutris wine mono protonplus gamemode libgamemode libgamemode-32bit MangoHud MangoHud-32bit Vulkan-Tools mesa-vulkan-radeon mesa-vulkan-radeon-32bit glu glu-32bit alsa-lib-32bit freetype-32bit libcurl-32bit libopenal-32bit libpulseaudio-32bit
    sudo xbps-install -Sy power-profiles-daemon usbguard fastfetch flatpak nvtop btop cava cmatrix foot foot-terminfo zsh zsh-autosuggestions zsh-completions zsh-history-substring-search zsh-syntax-highlighting font-open-dyslexic-ttf python3 vesktop vscodium audiotube
    fc-cache -f

### 5. Fuera del home (rc.local y servicio de energia)

    bash ~/.local/share/chezmoi/system-restore.sh

### 6. Rust, miri y lavat

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
    export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
    mkdir -p ~/src
    [ -d ~/src/miri/.git ] || git clone --depth 1 https://github.com/MintyDoggo/miri ~/src/miri
    cd ~/src/miri && cargo build --release && install -Dm755 target/release/miri ~/.local/bin/miri && cd ~
    [ -d ~/src/lavat/.git ] || git clone https://github.com/AngelJumbo/lavat ~/src/lavat
    cd ~/src/lavat && make install PREFIX="$HOME/.local" && cd ~

### 7. Flatpak

    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    for a in org.vinegarhq.Sober io.mrarm.mcpelauncher app.ytmdesktop.ytmdesktop io.github.kolunmi.Bazaar io.github.gnacho.Scribe ai.storyteller.artcraft-launcher ai.storyteller.deckcraft ai.storyteller.wordcraft; do flatpak install -y flathub "$a" || echo "FALLO: $a"; done

### 8. Cierre

    getent passwd "$USER" | grep -q ':/usr/bin/zsh$' || chsh -s /usr/bin/zsh
    sudo reboot

## Notas

- Brillo: funciona con el arranque por defecto (dispositivo nvidia_wmi_ec_backlight, ya configurado en noctalia/brightness.toml). No agregar acpi_backlight a GRUB: con vendor no aparece ningun dispositivo.
- dGPU: gpu-mode muestra y cambia el modo; dgpu-on y dgpu-off la activan o apagan. El estado de dgpu_disable persiste en el firmware. Para jugar con la NVIDIA, en Steam: odyssey-prime %command%
- ROG Control Center y asusctl: descartados con el kernel 6.12 (falta asus-armoury, que pide kernel 7). Fuente usada: tag 6.5.0 de opengamingcollective/asusctl.
- No esta en el respaldo: partidas y datos de juegos, ~/.var/app, ~/.steam, ~/src, conexiones Wi-Fi, llave SSH.
