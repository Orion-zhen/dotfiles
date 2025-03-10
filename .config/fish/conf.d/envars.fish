set -x LANG zh_CN.UTF-8

# fcitx5 输入法支持
set -x GTK_IN_MODULE fcitx
set -x QT_IM_MODULE fcitx
set -x XMODIFIERS "@im=fcitx"

# no_proxy 设置
set -x no_proxy "localhost,127.0.0.1"

if test -d /opt/cuda
    set -x CUDA_HOME /opt/cuda
end

if test -d /opt/rocm
    set -x ROCM_HOME /opt/rocm
end

if test -d $HOME/.cert
    set -x SSL_HOME $HOME/.cert
end

if test -d $HOME/ai/Models
    set -x MODELS $HOME/ai/Models
end

set -x GPG_TTY $(tty)

# set -x HOMEBREW_NO_INSTALL_CLEANUP false

# export HOMEBREW_API_DOMAIN
# export HOMEBREW_BOTTLE_DOMAIN
# export HOMEBREW_PIP_INDEX_URL

# Wine 相关设置（如果需要，可取消注释）
# set -x WINEARCH win32
# set -x WINEPREFIX ~/.local/share/wineprefixes/wine32