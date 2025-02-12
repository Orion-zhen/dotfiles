function la
    if type -q eza
        eza --icons --group-directories-first --color=always --header --long --git --all $argv
    else
        ls -lah --color=auto --group-directories-first $argv
    end
end