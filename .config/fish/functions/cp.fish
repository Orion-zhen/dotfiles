function cp --wraps cp
    if type -q advcp
        advcp -i -g -v $argv
    else
        command cp $argv
    end
end