function tree
    if type -q eza
        eza --icons --group-directories-first --color=always --tree $argv
    else if type -q tree
        tree --dirsfirst $argv
    else
        echo "No tree command found"
    end
end