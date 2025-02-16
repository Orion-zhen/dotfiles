function mv --wraps mv
    if type -q advmv
        advmv -i -g -v $argv
    else
        command mv $argv
    end
end
