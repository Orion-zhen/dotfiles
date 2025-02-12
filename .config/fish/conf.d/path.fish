set -x PATH $PATH $HOME/.local/bin

if test -d /opt/cuda
    set -x PATH $PATH /opt/cuda/bin
end

if test -d /opt/rocm
    set -x PATH $PATH /opt/rocm/bin
end