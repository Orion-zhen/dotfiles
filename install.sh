# apt-install()
# {
#     if [ -f /etc/os-release ]; then
#         source /etc/os-release

#     alias install="sudo apt install -y"
#     echo "====================="
#     echo "Installing DevKits..."
#     echo "====================="
#     install openssh-server curl wget
#     install samba samba-common
#     install ca-certificates curl gnupg
#     install build-essential pkg-config python-is-python3 ninja-build python3-pip python3-full
#     install vim git git-lfs
#     install net-tools tmux
#     install universal-ctags timeshift libfuse2
#     install autojump zsh
#     install htop powertop stress
#     install trash-cli

#     echo "===================="
#     echo "Installing Docker..."
#     echo "===================="
#     sudo install -m 0755 -d /etc/apt/keyrings
#     curl -fsSL https://download.docker.com/linux/$ID/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
#     sudo chmod a+r /etc/apt/keyrings/docker.gpg
#     sudo add-apt-repository "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$ID$(. /etc/os-release && echo "$VERSION_CODENAME") stable"
#     sudo apt update
#     install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
#     sudo groupadd docker
#     sudo usermod -aG docker $USER

#     echo "====================="
#     echo "Installing Flatpak..."
#     echo "====================="
#     install flatpak
#     flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

#     echo "===================="
#     echo "Installing Tailscale"
#     echo "===================="
#     curl -fsSL https://tailscale.com/install.sh | sudo bash
# }

pacman-install()
{
    echo "=================="
    echo "Adding archlinuxcn"
    echo "=================="
    sudo cp /etc/pacman.conf /etc/pacman.conf.bak
    sudo echo "[archlinuxcn]" >>/etc/pacman.conf
    sudo echo "SigLevel = Optional TrustAll" >>/etc/pacman.conf
    sudo echo "Server = http://repo.archlinuxcn.org\$arch" >>/etc/pacman.conf
    sudo pacman -Syu

    echo "========================"
    echo "Installing KDE Plasma..."
    echo "========================"
    sudo pacman -S plasma kde-system konsole yekuake kvantum

    echo "====================="
    echo "Installing DevKits..."
    echo "====================="
    sudo pacman -S yay
    sudo pacman -S os-prober
    sudo pacman -S openssh openbsd-netcat
    sudo pacman -S vim neovim git git-lfs zsh tmux htop ctags s-tui docker docker-compose pkgconf
    sudo pacman -S cmake rust rust-src rust-analyzer dpkg
    sudo pacman -S ntfs-3g mtpfs mergerfs smartmontools dosfstools gvfs gvfs-mtp gvfs-smb
    sudo pacman -S timeshift autojump trash-cli atuin
    sudo pacman -S flatpak freerdp remmina flameshot
    sudo pacman -S ttf-hack-nerd noto-fonts-cjk
    sudo pacman -S ark okular obsidian mpv fuse2

    echo "================="
    echo "Installing fcitx5"
    echo "================="
    sudo pacman -S fcitx5-im fcitx5-chinese-addons

    echo "==================="
    echo "Installing Audio..."
    echo "==================="
    sudo pacman -S alsa-firmware alsa-oss alsa-utils alsa-tools pulseaudio pavucontrol

    echo "===================="
    echo "Installing Tailscale"
    echo "===================="
    sudo pacman -S tailscale
    sudo systemctl enable --now tailscaled

    sudo groupadd docker
    sudo usermod -aG docker $USER
    sudo systemctl enable --now docker.service docker.socket
}

aur-install()
{
    echo "PLEASE make sure that you have access to OUTER WORLD!"

    echo "=========================="
    echo "Installing nessessary apps"
    echo "=========================="
    sudo pacman -S yay
    yay -S visual-studio-code-bin
    yay -S google-chrome
    yay -S fcitx5-input-support
    yay -S udevil pmount

    echo "=================="
    echo "Installing applets"
    echo "=================="
    yay -S linuxqq
    yay -S wechat-uos-bwrap
    yay -S yesplaymusic
    yay -S realesrgan-ncnn-vulkan-bin
    yay -S fcitx5-skin-fluentlight-git
}

hyprland-install()
{
    echo "======================"
    echo "Installing Hyprland..."
    echo "======================"
    sudo pacman -S hyprland hyprpaper waybar tofi kitty thunar mako swayidle swaylock cliphist hyprland-interactive-screenshot pamixer brightnessctl playerctl polkit-kde-agent udiskie
}

omz-install()
{
    echo "======================="
    echo "Installing Oh-My-Zsh..."
    echo "======================="
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    mkdir ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/incr
    curl -fsSL https://mimosa-pudica.net/src/incr-0.2.zsh -o ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/incr/incr.zsh
}

dotfiles-install() {
    git clone https://github.com/Orion-zhen/dotfiles.git $HOME/dotfiles --recursive
    cp -r $HOME/dotfiles/.config $HOME/.config
    cp $HOME/dotfiles/.zshrc $HOME/.zshrc
}

banner() {
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


banner

if [ $# -eq 0 ]; then
    if command -v apt &>/dev/null; then
        apt-install
    elif command -v pacman &>/dev/null; then
        pacman-install
    else
        echo "Unsupported package manager."
        exit 1
    fi
fi

if [[ "$1" = "test" ]]; then
    echo "test"
elif [[ "$1" = "omz" ]]; then
    omz-install
elif [[ "$1" = aur ]]; then
    aur-install
elif [[ "$1" = hyprland ]]; then
    hyprland-install
fi