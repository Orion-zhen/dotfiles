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
    sudo pacman -S plasma kde-system konsole yakuake kvantum

    echo "====================="
    echo "Installing DevKits..."
    echo "====================="
    sudo pacman -S yay
    sudo pacman -S os-prober
    sudo pacman -S openssh openbsd-netcat wget net-tools
    sudo pacman -S vim neovim git git-lfs zsh tmux htop btop nvtop ctags s-tui docker docker-compose pkgconf unzip p7zip
    sudo pacman -S cmake rust rust-src rust-analyzer dpkg wireshark-qt
    sudo pacman -S ntfs-3g mtpfs mergerfs smartmontools dosfstools gvfs gvfs-mtp gvfs-smb samba
    sudo pacman -S timeshift autojump trash-cli atuin
    sudo pacman -S flatpak freerdp remmina flameshot
    sudo pacman -S ttf-hack-nerd noto-fonts-cjk
    sudo pacman -S ark okular obsidian mpv fuse2 kate
    sudo pacman -S cups cups-browsed ipp-usb colord logrotate

    echo "================="
    echo "Installing fcitx5"
    echo "================="
    sudo pacman -S fcitx5-im fcitx5-chinese-addons

    echo "==================="
    echo "Installing Audio..."
    echo "==================="
    sudo pacman -S alsa-firmware alsa-oss alsa-utils alsa-tools pavucontrol
    sudo pacman -S jack2 gst-plugins-bad zita-ajbridge

    echo "===================="
    echo "Installing Tailscale"
    echo "===================="
    sudo pacman -S tailscale
    sudo systemctl enable --now tailscaled

    sudo groupadd docker
    sudo usermod -aG docker $USER
    sudo usermod --append -G audio $USER
    sudo systemctl enable --now docker.service docker.socket
    sudo systemctl enable --now cronie.service
    sudo systemctl enable --now sshd.service
    sudo systemctl enable --now tailscaled.service
    sudo systemctl enable cups.service cups.socket cups-browsed.service
    
    sudo systemctl enable --now sddm
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
    yay -S wps-office-cn wps-office-mime-cn wps-mui-zh-cn ttf-wps-fonts ttf-ms-fonts wps-office-fonts libtiff5

    echo "=================="
    echo "Installing applets"
    echo "=================="
    yay -S linuxqq
    yay -S wechat-universal-bwrap
    echo "采用 bubblewrap 沙盒运行微信，对于家目录，默认只能对 '$XDG_DOCUMENTS_DIR/WeChat_Data' 读写...
          如需增加更多的读写目录，请在 '~/.config/wechat-universal/binds.list' 文件（如不存在请自行创建）中增加...
          一个路径一行，可以使用绝对路径，形如：/home/username/music
          也可以使用相对于运行用户家目录的相对路径，形如：pictures/screenshot"
    yay -S yesplaymusic
    yay -S realesrgan-ncnn-vulkan-bin
    yay -S fcitx5-skin-fluentlight-git
}

hyprland-install()
{
    echo "======================"
    echo "Installing Hyprland..."
    echo "======================"
    sudo pacman -S hyprland hyprpaper waybar tofi kitty thunar mako swayidle swaylock cliphist hyprland-interactive-screenshot pamixer brightnessctl playerctl polkit-kde-agent udiskie network-manager-applet blueman qt6ct
    yay -S hyprland-interactive-screenshot
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

help()
{
    echo "bash install.sh [options]"
    echo "options:"
    echo "default: 使用pacman安装常用的应用"
    echo "aur: 使用yay安装常用的aur软件"
    echo "omz: 安装配置oh-my-zsh"
    echo "hyprland: 安装hyprland及常用应用"
    echo "casaos: 安装casaos"
    echo "lite11: 安装QQ插件"
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


banner

if [ $# -eq 0 ]; then
    help
fi

if [ "$1" = "default" ]; then
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
elif [[ "$1" = "aur" ]]; then
    aur-install
elif [[ "$1" = "hyprland" ]]; then
    hyprland-install
elif [[ "$1" = "casaos" ]]; then
    curl -fsSL https://get.casaos.io | sudo bash
elif [[ "$1" = "liteqq" ]]; then
    curl -L "https://github.com/Mzdyl/LiteLoaderQQNT_Install/releases/latest/download/install_linux.sh" | bash
elif [[ "$1" = "pigcha" ]]; then
    curl -ksSL http://120.241.39.54:8088/linux/install.sh | sudo bash
fi
