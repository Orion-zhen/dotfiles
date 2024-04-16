# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
COMPLETION_WAITING_DOTS="%F{yellow}waiting>%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    autojump
    extract
    git
    sudo
    vscode
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source $ZSH_CUSTOM/plugins/incr/incr.zsh

# user's python
act()
{
    local current_dir=$(pwd)
    local found_file=false

    while [[ $current_dir != $HOME ]]; do
        if [[ -r "$current_dir/.venv/bin/activate" ]]; then
            source "$current_dir/.venv/bin/activate"
            found_file=true
            break
        fi
        current_dir=$(dirname "$current_dir")
    done

    if [[ $found_file == false && -r "$HOME/.venv/bin/activate" ]]; then
        source "$HOME/.venv/bin/activate"
    fi
}

function ce() {
    builtin cd "$@" && act
}

act

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
export PATH="$PATH:$HOME/.local/bin"

# You may need to manually set your language environment
export LANG=zh_CN.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias cls="clear"
alias zshcfg="code ~/.zshrc"
alias mkzsh="source ~/.zshrc"
alias jump="j"
alias unzip="x"
alias vs="code"
alias ts="trash-put"
alias nf="neofetch"
alias dcp="docker-compose"
alias nv="nvim"
# super resolution commands
if command -v realesrgan-ncnn-vulkan &> /dev/null; then
    alias imgsr="realesrgan-ncnn-vulkan"
elif command -v realcugan-nvnn-vulkan &> /dev/null; then
    alias imgsr="realcugan-ncnn-vulkan"
elif command -v waifu2x-ncnn-vulkan &> /dev/null; then
    alias imgsr="waifu2x-ncnn-vulkan"
fi

# list some pacage managers
if command -v apt &> /dev/null; then
    alias update="sudo apt update && sudo apt upgrade"
    alias install="sudo apt install"
    alias remove="sudo apt remove --purge"
    alias autoremove="sudo apt autoremove --purge"
elif command -v pacman &> /dev/null; then
    alias autoremove="pacman -Qtdq | sudo pacman -Rns -"
fi
# I have only used these above before :-)
# special ssh for kitty
if [ "$TERM" = "xterm-kitty" ]; then
  alias ssh="kitten ssh"
fi

alias pyvenv="python -m venv .venv"
alias dea="deactivate"

alias rtop="sudo radeontop"
alias ptop="sudo powertop"

if which PigchaProxy &> /dev/null; then
    export http_proxy=http://127.0.0.1:15732
    export https_proxy=http://127.0.0.1:15732
elif which pigchacli &> /dev/null; then
    export http_proxy=http://127.0.0.1:15777
    export https_proxy=http://127.0.0.1:15777
fi

if test -d "/opt/rocm"; then
    export PATH="/opt/rocm/bin:$PATH"
fi

export SSL_HOME=$HOME/.cert
export LLM_HOME=$HOME/ai/Models

# Function to execute a command inside a Docker container
docex() 
{
    local container_name="$1"
    local cmd="${2:-/bin/bash}"  # Default value for cmd is /bin/bash if not provided

    docker exec -it "$container_name" "$cmd"
}

# Function to connect to wifi in cli
wifictl()
{
    local wifi_id="$1"
    local password="$2"

    nmcli device wifi connect "$wifi_id" password "$password"
}

setprx()
{
    if which PigchaProxy &> /dev/null; then
        local default_port=15732
    elif which pigchacli &> /dev/null; then
        local default_port=15777
    else
        local default_port=15777
    fi

    local port=${1:-$default_port}
    echo "Setting proxy port to $port"
    export http_proxy=http://127.0.0.1:$port
    export https_proxy=http://127.0.0.1:$port
}

unprx()
{
    # init
    unset http_proxy
    unset https_proxy
}

# wine demands
# export WINEARCH=win32
# export WINEPREFIX=~/.local/share/wineprefixes/wine32

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if which atuin &> /dev/null; then
    eval "$(atuin init zsh)"
fi
