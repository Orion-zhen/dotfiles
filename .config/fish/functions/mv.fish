function mv --wraps mv
    if type -d advmv
        advmv -i -g -v $argv
    else
        command mv $argv
    end
end