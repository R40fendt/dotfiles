#!/bin/zsh

#autoload -U compinit && compinit
#source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
#setopt correct
eval "$(starship init zsh)"
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export PGHOST="/var/run/postgresql"
export FZF_DEFAULT_COMMAND='find . -type f'
export PATH=$PATH:/usr/local/go/bin

HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=50000

setopt inc_append_history

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


alias fzc='fzf --preview "bat {} --style=numbers --color=always --line-range=:500" \
  --bind "enter:execute(code {})"'
alias fza='fzf --preview "bat {} --style=numbers --color=always --line-range=:500" \
  --bind "enter:become(sudo vim {})"'
alias fzf='fzf --preview "bat {} --style=numbers --color=always --line-range=:500" \
  --bind "enter:become(vim {})"'
alias cp="rsync -ah --info=progress2"
alias fcd="source fcd"

alias cat="bat"

alias clear="clear && fastfetch"

alias l="eza -la"
alias ls="eza"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH="$HOME/.cargo/bin:$PATH"

export ANDROID_HOME=/home/jonas/Android/Sdk
export NDK_HOME=/home/jonas/Android/Sdk/ndk/29.0.13113456

export PATH="/home/linuxbrew/.linuxbrew/opt/node@22/bin:$PATH"
export PATH="/home/jonas/.local/bin:$PATH"

export SSH_AUTH_SOCK=/home/jonas/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock

alias yt="youtube-tui loadpage search"

eval "$(zoxide init --cmd=cd zsh)"
alias c="clear"

zmv() {
    # Prüfe, ob mehr als ein Argument übergeben wurde
    if [ "$#" -lt 2 ]; then
        command mv "$@"
        return
    fi

    # Zielverzeichnis = letztes Argument
    dest="${@: -1}"

    # Wenn das Zielverzeichnis nicht existiert, versuche es mit zoxide
    if [ ! -d "$dest" ]; then
        zpath=$(zoxide query "$dest" 2>/dev/null)
        if [ -n "$zpath" ]; then
            dest="$zpath"
            set -- "${@:1:$(($#-1))}" "$dest"
        fi
    fi

    command mv "$@"
}

zcp() {
    if [ "$#" -lt 2 ]; then
        command cp "$@"
        return
    fi

    dest="${@: -1}"

    if [ ! -d "$dest" ]; then
        zpath=$(zoxide query "$dest" 2>/dev/null)
        if [ -n "$zpath" ]; then
            dest="$zpath"
            set -- "${@:1:$(($#-1))}" "$dest"
        fi
    fi

    command cp "$@"
}

command_not_found_handler() {
    echo "Befehl '$1' nicht gefunden."

    #read -q "reply?Möchtest du in pacseek danach suchen? [y/N] "
    #echo
    #if [[ $reply == [Yy] ]]; then
    #    pacsea "$1"
    #else
    #    return 127
    #fi
}

#sl -eldw
fastfetch

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/jonas/.dart-cli-completion/zsh-config.zsh ]] && . /home/jonas/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

