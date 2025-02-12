function ll
    if type -q eza
        eza --icons --group-directories-first --color=always --header --long --git --no-user --no-permissions $argv
    else
        command ls -l --color=auto $argv
    end
end