function cp --wraps cp
    if type -q advcp
        advcp -i -g -v $argv
    else
        cp $argv
    end
end