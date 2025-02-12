# bat 主题选择命令
function bathemes --description "select bat theme interactively"
    if test (count $argv) -ge 1
        set file $argv[1]
    else
        set file "$HOME/.zshrc"
    end
    set -x BAT_THEME (bat --list-themes | fzf --preview "bat --theme={} --color=always $file")
end