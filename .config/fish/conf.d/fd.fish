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
