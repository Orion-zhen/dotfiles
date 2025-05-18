set -gx PATH $PATH $HOME/.local/bin

if test -d /opt/cuda
    set -gx PATH $PATH /opt/cuda/bin
end

if test -d /opt/rocm
    set -gx PATH $PATH /opt/rocm/bin
end

# 检查 $HOME/opt 是否存在
if test -d "$HOME/opt"
    # 遍历 $HOME/opt 下的所有一级子目录
    for sub in $HOME/opt/*
        # 确保 sub 是一个目录
        if test -d "$sub"
            # 如果存在 bin 子目录，则将其添加到 PATH 中
            if test -d "$sub/bin"
                set -gx PATH $sub/bin $PATH
            end
            # 如果存在 lib 子目录，则将其添加到 LD_LIBRARY_PATH 中
            if test -d "$sub/lib"
                set -gx LD_LIBRARY_PATH $sub/lib $LD_LIBRARY_PATH
                set -gx DYLD_LIBRARY_PATH $sub/lib $DYLD_LIBRARY_PATH
            end
        end
    end
end
