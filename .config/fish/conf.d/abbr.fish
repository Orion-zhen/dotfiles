abbr cls clear
abbr fishcfg "code ~/.config/fish/"
abbr mkfish "source ~/.config/fish/config.fish"
abbr vs code
abbr dbd "docker build"
abbr dcp "docker-compose"
abbr nv nvim
abbr dea deactivate

if type -q autojump
    abbr j "jump"
end

if type -q fastfetch
    abbr ff "fastfetch"
    abbr fetch "fastfetch"
else if type -q neofetch
    abbr nf "neofetch"
    abbr fetch "neofetch"
end

if type -q cpufetch
    abbr cf "cpufetch"
end

if type -q bat
    abbr cat bat
end

if type -q zoxide
    abbr cd z
end

if type -q tmux
    abbr tls "tmux ls"
    abbr tat "tmux attach -t"
    abbr tkill "tmux kill-session -t"
    abbr tmuxr "tmux rename-session"
    abbr tnew "tmux new -s"
end

if type -q yay
    abbr autoremove "yay -Qtdq | yay -Rns -"
    abbr autoclean "yay -Scc"
else if type -q pacman
    abbr autoremove "pacman -Qtdq | sudo pacman -Rns -"
    abbr autoclean "sudo pacman -Scc"
else if type -q pkg
    abbr autoremove "apt autoremove"
    abbr autoclean "pkg autoclean"
else if type -q brew
    abbr install "brew install"
    abbr remove "brew uninstall"
    abbr update "brew update && brew upgrade"
else if type -q apt
    abbr update "sudo apt update && sudo apt upgrade"
    abbr autoremove "sudo apt autoremove"
    abbr remove "sudo apt remove --purge"
    abbr install "sudo apt install"
end

# kitty 终端下特殊的 ssh 别名
if test $TERM = xterm-kitty
    abbr ssh "kitten ssh"
end

# 超分辨率工具命令，根据系统中可用的工具依次设置 imgsr 别名
if type -q realesrgan-ncnn-vulkan
    abbr imgsr realesrgan-ncnn-vulkan
else if type -q realcugan-nvnn-vulkan
    abbr imgsr realcugan-ncnn-vulkan
else if type -q waifu2x-ncnn-vulkan
    abbr imgsr waifu2x-ncnn-vulkan
end

if test (uname) = "Darwin"
    alias python python3
    alias pip pip3
end
