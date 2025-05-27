#!/bin/zsh

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

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH="$HOME/.cargo/bin:$PATH"

export ANDROID_HOME=/home/jonas/Android/Sdk
export NDK_HOME=/home/jonas/Android/Sdk/ndk/29.0.13113456

export PATH="/home/linuxbrew/.linuxbrew/opt/node@22/bin:$PATH"
