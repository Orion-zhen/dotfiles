function jump --description "jump to dir with fuzzy name"
    if type -q autojump
        if test (count $argv) -lt 1
            echo "Usage: jump [dir]"
            return 1
        end
        cd $(autojump $argv)
    else
        echo "autojump not installed"
    end
end