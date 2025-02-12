# 当删除文件时, 提示确认
function rm --wraps rm
    if type -q trash-put
        trash-put -v $argv
    else
        command rm -i $argv
    end
end