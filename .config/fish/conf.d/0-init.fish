# 文件名用 0 开头是为了保证它在配置文件之前加载, 以保证正确的初始化顺序

if type -q atuin
    atuin init fish | source
end

if type -q fzf
    fzf --fish | source
end

if type -q zoxide
    zoxide init fish | source
end

if type -q starship
    starship init fish | source
end
