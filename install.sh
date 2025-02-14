pacman-install() {
    # echo "=================="
    # echo "Adding archlinuxcn"
    # echo "=================="
    # sudo cp /etc/pacman.conf /etc/pacman.conf.bak
    # sudo echo "[archlinuxcn]" >>/etc/pacman.conf
    # sudo echo "SigLevel = Optional TrustAll" >>/etc/pacman.conf
    # sudo echo "Server = https://mirror.tuna.tsinghua.edu.cn/archlinuxcn/$arch" >>/etc/pacman.conf
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
    sudo pacman -S openssh openbsd-netcat wget net-tools bind
    sudo pacman -S docker docker-compose docker-buildx
    sudo pacman -S pkgconf unzip p7zip unrar
    sudo pacman -S cmake meson cpio rust rust-src rust-analyzer go npm dpkg wireshark-qt mold ccache
    sudo pacman -S timeshift
    sudo pacman -S flatpak freerdp remmina flameshot
    sudo pacman -S ttf-hack-nerd noto-fonts-cjk
    sudo pacman -S ark okular obsidian mpv fuse2 kate obs-studio krdp
    sudo pacman -S cups cups-browsed ipp-usb colord logrotate

    echo "=========================="
    echo "Installing Shell Tweaks..."
    echo "=========================="
    sudo pacman -S zsh tmux fzf fd bat eza tldr thefuck trash-cli atuin autojump starship

    echo "==========================="
    echo "Installing Storage Utils..."
    echo "==========================="
    sudo pacman -S ntfs-3g mtpfs mergerfs smartmontools dosfstools gvfs gvfs-mtp gvfs-smb samba

    echo "==============================="
    echo "Installing Resource Monitors..."
    echo "==============================="
    sudo pacman -S htop btop nvtop s-tui fastfetch baobab

    echo "=========================="
    echo "Installing NeoVim..."
    echo "=========================="
    sudo pacman -S neovim python-pynvim luarocks prettier tree-sitter-cli pyright ripgrep

    echo "================="
    echo "Installing fcitx5"
    echo "================="
    sudo pacman -S fcitx5-im fcitx5-chinese-addons

    echo "==================="
    echo "Installing Audio..."
    echo "==================="
    sudo pacman -S alsa-firmware alsa-oss alsa-utils alsa-tools pavucontrol

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

    ssh-keygen
    git config --global gpg.format ssh
    git config --global user.signingkey $HOME/.ssh/id_ed25519.pub
}

aur-install() {
    echo "PLEASE make sure that you have access to OUTER WORLD!"

    echo "=============================="
    echo "Installing nessessary aur apps"
    echo "=============================="
    sudo pacman -S yay
    yay -S visual-studio-code-bin
    yay -S google-chrome
    yay -S fcitx5-input-support
    yay -S gem
    yay -S udevil pmount
    yay -S obs-vaapi
    yay -S nodejs-gitmoji-cli
}

applets-install() {
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
}

themes-install () {
    sudo pacman -S orchis-theme tela-circle-icon-theme-all
    yay -S fcitx5-skin-fluentlight-git fcitx5-skin-seasons
}

hyprland-install() {
    echo "======================"
    echo "Installing Hyprland..."
    echo "======================"
    sudo pacman -S hyprland hyprpaper hypridle hyprlock waybar wlogout wofi kitty mako cliphist pamixer brightnessctl playerctl polkit-kde-agent udiskie network-manager-applet blueman nwg-look orchis-theme
    sudo pacman -S nautilus nautilus-share nautilus-image-converter nautilus-metadata-editor sushi
    yay -S hyprland-interactive-screenshot
    hyprpm update
}

omz-install() {
    echo "======================="
    echo "Installing Oh-My-Zsh..."
    echo "======================="
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/wfxr/forgit.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/forgit
    mkdir ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/incr
    curl -fsSL https://raw.githubusercontent.com/Orion-zhen/incr-zsh/main/incr.zsh -o ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/incr/incr.zsh
}

dotfiles-install() {
    git clone https://github.com/Orion-zhen/dotfiles.git $HOME/dotfiles --recursive
    cp $HOME/dotfiles/.zshrc $HOME/.zshrc
    echo "配置文件可选择安装，请自行将配置文件夹复制到 $HOME/.config/ 对应的目录下"
}

nekoray-install() {
    sudo pacman -S nekoray sing-box sing-box-geoip-db sing-box-geoip-rule-set sing-box-geosite-db sing-box-geosite-rule-set hysteria naiveproxy
    sudo systemctl enable --now sing-box
}

help() {
    echo "bash install.sh [options]"
    echo "options:"
    echo "default: 使用pacman安装常用的应用"
    echo "aur: 使用yay安装常用的aur软件"
    echo "applets: 安装常用桌面应用"
    echo "cfg: 安装配置文件"
    echo "omz: 安装配置oh-my-zsh"
    echo "hyprland: 安装hyprland及常用应用"
    echo "casaos: 安装casaos"
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
    help
fi

if [ "$1" = "default" ]; then
    if command -v pacman &>/dev/null; then
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
elif [[ "$1" = "applets" ]]; then
    applets-install
elif [[ "$1" = "hyprland" ]]; then
    hyprland-install
elif [[ "$1" = "themes" ]]; then
    themes-install
elif [[ "$1" = "cfg" ]]; then
    dotfiles-install
elif [[ "$1" = "casaos" ]]; then
    curl -fsSL https://get.casaos.io | sudo bash
fi
