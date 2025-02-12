if type -q fzf
    # 设置 fzf 默认选项
    set -x FZF_DETAULT_OPTS ""

    if type -q bat
        set -x FZF_CTRL_T_OPTS "--preview 'bat --color=always --line-range :500 {}'"
    end
    if type -q eza
        set -x FZF_ALT_C_OPTS "--preview 'eza --tree --color=always {} | head -200'"
    end
end
