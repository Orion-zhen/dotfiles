apt-install()
{
    if [ -f /etc/os-release ]; then
        source /etc/os-release
    
    alias install="sudo apt install -y"
    echo "\n====================="
    echo "Installing DevKits..."
    echo "=====================\n"
    install openssh-server curl wget
    install samba samba-common
    install ca-certificates curl gnupg
    install build-essential pkg-config python-is-python3 ninja-build python3-pip python3-full
    install vim git git-lfs
    install net-tools tmux
    install universal-ctags timeshift libfuse2
    install autojump zsh
    install htop powertop stress
    install trash-cli
    
    echo "\n===================="
    echo "Installing Docker..."
    echo "====================\n"
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/$ID/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    sudo add-apt-repository "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$ID$(. /etc/os-release && echo "$VERSION_CODENAME") stable"
    sudo apt update
    install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo groupadd docker
    sudo usermod -aG docker $USER

    echo "\n====================="
    echo "Installing Flatpak..."
    echo "=====================\n"
    install flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    echo "\n===================="
    echo "Installing Tailscale"
    echo "====================\n"
    curl -fsSL https://tailscale.com/install.sh | sudo bash
}

pacman-install()
{
    echo "\n=================="
    echo "Adding archlinuxcn"
    echo "==================\n"
    sudo cp /etc/pacman.conf /etc/pacman.conf.bak
    sudo echo "[archlinuxcn]" >> /etc/pacman.conf
    sudo echo "SigLevel = Optional TrustAll" >> /etc/pacman.conf
    sudo echo "Server = http://repo.archlinuxcn.org\$arch" >> /etc/pacman.conf
    sudo pacman -Syu

    echo "\n========================"
    echo "Installing KDE Plasma..."
    echo "========================\n"
    sudo pacman -S plasma kde-system konsole yekuake kvantum

    echo "\n====================="
    echo "Installing DevKits..."
    echo "=====================\n"
    sudo pacman -S yay
    yay -S openssh openbsd-netcat
    yay -S vim git git-lfs zsh tmux htop powertop ctags s-tui docker docker-compose
    yay -S cmake rust rust-src
    yay -S ntfs-3g mergerfs smartmontools dosfstools fuse2
    yay -S timeshift autojump trash-cli
    yay -S flatpak freerdp remmina
    yay -S ttf-hack-nerd noto-fonts-cjk
    yay -S visual-studio-code-bin
    yay -S ark okular obsidian

    echo "\n================="
    echo "Installing fcitx5"
    echo "=================\n"
    yay -S fcitx5-im fcitx5-chinese-addons fcitx5-input-support

    echo "\n==================="
    echo "Installing Audio..."
    echo "===================\n"
    yay -S alsa-firmware alsa-oss alsa-utils alsa-tools pulseaudio pavucontrol
    
    echo "\n======================"
    echo "Installing Hyprland..."
    echo "======================\n"
    yay -S hyprland hyprpaper waybar tofi kitty thunar mako swayidle swaylock cliphist hyprland-interactive-screenshot pamixer brightnessctl playerctl polkit-kde-agent udiskie gvfs

    echo "\n===================="
    echo "Installing Tailscale"
    echo "====================\n"
    yay -S tailscale
    sudo systemctl enable --now tailscaled

    sudo groupadd docker
    sudo usermod -aG docker $USER
}

omz-install()
{
    echo "\n======================="
    echo "Installing Oh-My-Zsh..."
    echo "=======================\n"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

dotfiles-install()
{
    git clone https://github.com/Orion-zhen/dotfiles.git $HOME/dotfiles --recursive
    cp -r $HOME/dotfiles/.config $HOME/.config
    cp -r $HOME/dotfiles/custom $HOME/.oh-my-zsh/custom
    cp $HOME/dotfiles/.zshrc $HOME/.zshrc
}

banner()
{
    echo "
 █████   ███   █████          ████                                                 █████                                                 
░░███   ░███  ░░███          ░░███                                                ░░███                                                  
 ░███   ░███   ░███   ██████  ░███   ██████   ██████  █████████████    ██████     ███████    ██████                                      
 ░███   ░███   ░███  ███░░███ ░███  ███░░███ ███░░███░░███░░███░░███  ███░░███   ░░░███░    ███░░███                                     
 ░░███  █████  ███  ░███████  ░███ ░███ ░░░ ░███ ░███ ░███ ░███ ░███ ░███████      ░███    ░███ ░███                                     
  ░░░█████░█████░   ░███░░░   ░███ ░███  ███░███ ░███ ░███ ░███ ░███ ░███░░░       ░███ ███░███ ░███                                     
    ░░███ ░░███     ░░██████  █████░░██████ ░░██████  █████░███ █████░░██████      ░░█████ ░░██████                                      
     ░░░   ░░░       ░░░░░░  ░░░░░  ░░░░░░   ░░░░░░  ░░░░░ ░░░ ░░░░░  ░░░░░░        ░░░░░   ░░░░░░                                       
                                                                                                                                         
                                                                                                                                         
                                                                                                                                         
    ███████               ███                       ██            ██████████             █████       ██████   ███  ████                  
  ███░░░░░███            ░░░                       ███           ░░███░░░░███           ░░███       ███░░███ ░░░  ░░███                  
 ███     ░░███ ████████  ████   ██████  ████████  ░░░   █████     ░███   ░░███  ██████  ███████    ░███ ░░░  ████  ░███   ██████   █████ 
░███      ░███░░███░░███░░███  ███░░███░░███░░███      ███░░      ░███    ░███ ███░░███░░░███░    ███████   ░░███  ░███  ███░░███ ███░░  
░███      ░███ ░███ ░░░  ░███ ░███ ░███ ░███ ░███     ░░█████     ░███    ░███░███ ░███  ░███    ░░░███░     ░███  ░███ ░███████ ░░█████ 
░░███     ███  ░███      ░███ ░███ ░███ ░███ ░███      ░░░░███    ░███    ███ ░███ ░███  ░███ ███  ░███      ░███  ░███ ░███░░░   ░░░░███
 ░░░███████░   █████     █████░░██████  ████ █████     ██████     ██████████  ░░██████   ░░█████   █████     █████ █████░░██████  ██████ 
   ░░░░░░░    ░░░░░     ░░░░░  ░░░░░░  ░░░░ ░░░░░     ░░░░░░     ░░░░░░░░░░    ░░░░░░     ░░░░░   ░░░░░     ░░░░░ ░░░░░  ░░░░░░  ░░░░░░  
                                                                                                                                         
                                                                                                                                         
                                                                                                                                                                  
"
}

main()
{
    banner
    
    if command -v apt &> /dev/null; then
        apt-install
    elif command -v pacman &> /dev/null; then
        pacman-install
    else
        echo "Unsupported package manager."
        exit 1
    fi
    omz-install
    dotfiles-install
}

main