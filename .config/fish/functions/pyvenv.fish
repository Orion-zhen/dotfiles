function pyvenv --description "create a new pyvenv"
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