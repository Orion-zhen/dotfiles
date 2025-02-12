# 自动激活虚拟环境。向上查找当前目录下是否存在 .venv/bin/activate.fish 文件，若未找到则尝试 $HOME/.venv/bin/activate.fish
function act --description "activate pyvenv"
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