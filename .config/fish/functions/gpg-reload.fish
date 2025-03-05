function gpg-reload --description "Reload GPG agent and scdaemon"
    pkill scdaemon
    pkill gpg-agent
    gpg-connect-agent /bye >/dev/null 2>&1
    gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
    gpgconf --reload gpg-agent
end
