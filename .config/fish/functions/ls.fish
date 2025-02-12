function ls
    if type -q eza
        eza --icons --group-directories-first --color=always --header --long --git --no-user --no-permissions --no-time $argv
    else
        command ls --color=auto $argv
    end
end