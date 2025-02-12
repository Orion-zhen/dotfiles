if status is-interactive
    # Commands to run in interactive sessions can go here
end
###############################
#       Custom functions      #
###############################

# 当删除文件时, 提示确认
function rm
    command rm -i $argv
end

# 在 Docker 容器中执行命令，默认命令为 /bin/bash
function docex --description "在 Docker 容器中执行命令，默认命令为 /bin/bash"
    if test (count $argv) -lt 1
        echo "Usage: docex container_name [cmd]"
        return 1
    end
    set container_name $argv[1]
    if test (count $argv) -ge 2
        set cmd $argv[2]
    else
        set cmd /bin/bash
    end
    docker exec -it $container_name $cmd
end

# 连接 WiFi
function wifictl --description "连接 WiFi"
    if test (count $argv) -lt 2
        echo "Usage: wifictl wifi_id password"
        return 1
    end
    set wifi_id $argv[1]
    set password $argv[2]
    nmcli device wifi connect $wifi_id password $password
end

# 设置代理，如果传入两个参数，第一个为 IP，第二个为端口；若只传入一个参数，则 IP 固定为 127.0.0.1
function setprx
    if test (count $argv) -eq 2
        set -x http_proxy "http://$argv[1]:$argv[2]"
        set -x https_proxy "http://$argv[1]:$argv[2]"
        echo "Proxy set to $argv[1]:$argv[2]"
    else if test (count $argv) -eq 1
        set -x http_proxy "http://127.0.0.1:$argv[1]"
        set -x https_proxy "http://127.0.0.1:$argv[1]"
        echo "Proxy set to 127.0.0.1:$argv[1]"
    else
        echo "Usage: setprx [IP] [PORT]"
        echo "or     setprx [PORT]"
    end
end

# 取消代理设置
function unprx
    if not set -q http_proxy -o not set -q https_proxy
        echo "No proxies are set yet"
    else
        echo "Unset $http_proxy and $https_proxy"
        set -e http_proxy
        set -e https_proxy
    end
end

# 设置 CUDA 可见设备，默认设备为 0
function setcuda
    set default_device 0
    if test (count $argv) -ge 1
        set device $argv[1]
    else
        set device $default_device
    end
    echo "cuda visible device = $device"
    set -x CUDA_VISIBLE_DEVICES $device
end

# 取消 CUDA 设备设置
function uncuda
    set -e CUDA_VISIBLE_DEVICES
end

# 自动激活虚拟环境。向上查找当前目录下是否存在 .venv/bin/activate.fish 文件，若未找到则尝试 $HOME/.venv/bin/activate.fish
function act
    set venv_dir ".venv"
    if test (count $argv) -ge 1
        set venv_dir $argv[1]
    end
    set current_dir (pwd)
    set found 0
    while test $current_dir != $HOME
        if test -r "$current_dir/$venv_dir/bin/activate.fish"
            source "$current_dir/$venv_dir/bin/activate.fish"
            set found 1
            break
        end
        set current_dir (dirname $current_dir)
    end
    if test $found -eq 0 -a -r "$HOME/$venv_dir/bin/activate"
        source "$HOME/$venv_dir/bin/activate.fish"
    end
end

function pyvenv --description "创建 Python 虚拟环境"
    set venv_dir ".venv"
    if test (count $argv) -ge 1
        set venv_dir $argv[1]
    end
    if test -d $venv_dir
        echo "虚拟环境 $venv_dir 已存在"
        return 1
    end
    python -m venv $venv_dir
    act $venv_dir
end

# 进入目录并自动激活虚拟环境
function ce --wraps cd
    cd $argv; and act
end

function jump
    if test (count $argv) -lt 1
        echo "Usage: jump [dir]"
        return 1
    end
    cd $(autojump $argv)
end

function mvn-install --description "安装本地 jar 包到本地仓库"
    # 交互式提示输入各个参数
    # 如果系统中存在 fzf，则使用 fzf 进行文件选择；否则使用 read 提示
    if type -q fzf
        echo "请选择文件路径 (支持模糊搜索): "
        # 这里调用 fzf 的文件查找功能（你可以根据需要调整查找范围，比如用 find 命令）
        set file (fzf --prompt "File> " --query "" )
        if test -z "$file"
            echo "未选择文件, 退出"
            return 1
        end
        echo $file
    else
        read -P "请输入文件路径 (file): " file
    end
    read -P "请输入 groupId: " groupId
    read -P "请输入 artifactId: " artifactId
    read -P "请输入 version: " pkgVersion
    # 对 packaging 参数提供候选值: jar、war、pom、ear
    set packaging_options jar war pom ear
    if type -q fzf
        echo "请选择 packaging (可选值: jar, war, pom, ear): "
        # 用 fzf 从预设的选项中选择
        set packaging (printf "%s\n" $packaging_options | fzf --prompt "Packaging> ")
        if test -z "$packaging"
            echo "未选择 packaging, 退出"
            return 1
        end
    else
        read -P "请输入 packaging: " packaging
    end

    echo "mvn install:install-file -Dfile=$file -DgroupId=$groupId -DartifactId=$artifactId -Dversion=$pkgVersion -Dpackaging=$packaging -DgeneratePom=true"

    # 最终确认
    read -P "是否确认执行？ (y/N): " confirm
    if test "$confirm" != y -a "$confirm" != Y
        echo 已取消执行
        return 1
    end

    # 执行 maven 命令
    mvn install:install-file -Dfile="$file" -DgroupId="$groupId" -DartifactId="$artifactId" -Dversion="$pkgVersion" -Dpackaging="$packaging" -DgeneratePom=true
end

function mvn-new --description "创建新的 Maven 项目"
    # 交互式提示输入各个参数
    read -P "请输入 groupId: " groupId
    read -P "请输入 artifactId: " artifactId

    echo "mvn archetype:generate -DgroupId=$groupId -DartifactId=$artifactId -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false"

    # 最终确认
    read -P "是否确认执行？ (y/N): " confirm
    if test "$confirm" != y -a "$confirm" != Y
        echo 已取消执行
        return 1
    end

    # 执行 maven 命令
    mvn archetype:generate -DgroupId="$groupId" -DartifactId="$artifactId" -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
end

################################
# Custom environment variables #
################################

# 添加自定义路径到 PATH
set -x PATH $PATH $HOME/.local/bin
set -x LANG zh_CN.UTF-8

# fcitx5 输入法支持
set -x GTK_IN_MODULE fcitx
set -x QT_IM_MODULE fcitx
set -x XMODIFIERS "@im=fcitx"

# 国内镜像源设置，根据时区判断（CST 时区时设置）
if test (date +%Z) = CST
    set -x HF_ENDPOINT "https://hf-mirror.com"
    set -x PUB_HOSTED_URL "https://mirrors.cernet.edu.cn/dart-pub"
    set -x FLUTTER_STORAGE_BASE_URL "https://mirrors.cernet.edu.cn/flutter"
    set -x NODE_MIRROR "https://mirrors.cernet.edu.cn/nodejs-release"
    set -x NVM_NODEJS_ORG_MIRROR "https://mirrors.cernet.edu.cn/nodejs-release"
    set -x RUSTUP_UPDATE_ROOT "https://mirrors.cernet.edu.cn/rustup/rustup"
    set -x RUSTUP_DIST_SERVER "https://mirrors.cernet.edu.cn/rustup"
end

# no_proxy 设置
set -x no_proxy "localhost,127.0.0.1"

if test -d /opt/cuda
    set -x CUDA_HOME /opt/cuda
end

# 如果 /opt/rocm 存在，将其添加到 PATH
if test -d /opt/rocm
    set -x ROCM_HOME /opt/rocm
    set -x PATH /opt/rocm/bin $PATH
end

set -x SSL_HOME $HOME/.cert
set -x LLM_HOME $HOME/ai/Models

# Wine 相关设置（如果需要，可取消注释）
# set -x WINEARCH win32
# set -x WINEPREFIX ~/.local/share/wineprefixes/wine32


#########################
#        Aliases        #
#########################

abbr cls clear
abbr fishcfg "code ~/.config/fish/config.fish"
abbr mkfish "source ~/.config/fish/config.fish"
abbr j jump
abbr vs code
abbr ts trash-put
abbr ff fastfetch
abbr dbd "docker build"
abbr dcp docker-compose
abbr nv nvim
abbr dea deactivate

# 如果 bat 命令存在，则用 bat 代替 cat
if type -q bat
    abbr cat bat
end

# 使用 zoxide 实现更智能的 cd
if type -q zoxide
    # 将 zoxide 初始化为 fish 版本，并将 cd 重定义为 z
    zoxide init fish | source
    abbr cd z
end

# 使用 eza 实现更现代的 ls 命令
if type -q eza
    abbr ls "eza --icons --group-directories-first --color=always --header --long --git --no-user --no-permissions --no-time"
    abbr ll "eza --icons --group-directories-first --color=always --header --long --git --no-user --no-permissions"
    abbr la "eza --icons --group-directories-first --color=always --header --long --git --all"
    abbr tree "eza --icons --group-directories-first --color=always --tree"
else
    abbr ls "ls --color=auto"
    abbr ll "ls -l"
    abbr la "ls -la"
end

# 超分辨率工具命令，根据系统中可用的工具依次设置 imgsr 别名
if type -q realesrgan-ncnn-vulkan
    abbr imgsr realesrgan-ncnn-vulkan
else if type -q realcugan-nvnn-vulkan
    abbr imgsr realcugan-ncnn-vulkan
else if type -q waifu2x-ncnn-vulkan
    abbr imgsr waifu2x-ncnn-vulkan
end

# tmux 相关别名
if type -q tmux
    abbr tls "tmux ls"
    abbr tat "tmux attach -t"
    abbr tkill "tmux kill-session -t"
    abbr tmuxr "tmux rename-session"
    abbr tnew "tmux new -s"
end

# 包管理器相关别名
if type -q apt
    abbr update "sudo apt update && sudo apt upgrade"
    abbr install "sudo apt install"
    abbr remove "sudo apt remove --purge"
    abbr autoremove "sudo apt autoremove --purge"
else if type -q pacman
    abbr autoremove "pacman -Qtdq | sudo pacman -Rns -"
end

# kitty 终端下特殊的 ssh 别名
if test $TERM = xterm-kitty
    abbr ssh "kitten ssh"
end

# atuin 历史记录工具（若 atuin 提供 fish 集成，则使用其输出并加载）
if type -q atuin
    atuin init fish | source
end

# 配置 thefuck
if type -q thefuck
    thefuck --alias | source
    thefuck --alias fk | source
end

# 配置 fzf
if type -q fzf
    # 初始化 fzf 的 fish 集成（注意：fzf 的 fish 集成可能需要单独安装）
    fzf --fish | source

    # 设置 fzf 默认选项
    set -x FZF_DETAULT_OPTS ""

    if type -q bat
        set -x FZF_CTRL_T_OPTS "--preview 'bat --color=always --line-range :500 {}'"
    end
    if type -q eza
        set -x FZF_ALT_C_OPTS "--preview 'eza --tree --color=always {} | head -200'"
    end
end

# 使用 fd 代替 find，并配置 fzf 补全
if type -q fd
    set -x FZF_DEFAULT_COMMAND "fd --hidden --follow --exclude .git"
    set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    set -x FZF_ALT_C_COMMAND "fd --type d --hidden --follow --exclude .git"

    # 用于 ** + Tab 补全
    function _fzf_comprun
        set cmd $argv[1]
        set args $argv[2..-1]
        switch $cmd
            case cd
                fzf --preview 'eza --tree --color=always --icons {} | head -200' $args
            case export unset
                fzf --preview "eval 'echo \$ {}'" $args
            case ssh
                fzf --preview 'dig {}'
            case '*'
                fzf --preview 'bat -n --color=always --line-range :500 {}' $args
        end
    end

    function _fzf_compgen_path
        fd --hidden --follow --exclude .git . $argv
    end

    function _fzf_compgen_dir
        fd --type d --hidden --follow --exclude .git . $argv
    end
end

# bat 主题选择命令
function bathemes
    if test (count $argv) -ge 1
        set file $argv[1]
    else
        set file "$HOME/.zshrc"
    end
    set -x BAT_THEME (bat --list-themes | fzf --preview "bat --theme={} --color=always $file")
end

starship init fish | source
