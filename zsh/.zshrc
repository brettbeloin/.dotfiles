
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' ''
zstyle :compinstall filename '/home/brett/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob notify
# End of lines configured by zsh-newuser-install
#

if [[ "$PWD" == "/" ]]; then

    PS1=$'%c \n%n@%m %D{%a %b %d %H:%M} $ '

else

    PS1=$'%c/ \n%n@%m %D{%a %b %d %H:%M} $ '

fi

# fastfetch

export MANPAGER='nvim +Man!'

alias sysEdit='nvim ~/.zshrc && source ~/.zshrc'
alias sysRead='cat ~/.zshrc'
alias sleep='sudo zzz'
alias poweroff="sudo loginctl poweroff"
alias reboot="sudo loginctl reboot"
alias vim='nvim'
#alias gEmacs='emacsclient -c -a "nvim"'
#alias tEmacs='emacsclient -t -a "nvim"'
alias df="df -h"
alias lsblk="lsblk -lf"
alias pkgSearch="xbps-query -Rs"
alias search="xbps-query -S"
alias trm="trash -v"
alias cd="z"
alias la="ls -la"

export XDG_SCREENSHOTS_DIR=~/Pictures/Screenshots/
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
# export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/bin/lua-language-server:$PATH"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export NODE_PATH="$HOME/.local/lib/node_modules:$NODE_PATH"
export npm_config_prefix="$HOME/.local"
export PATH="$PATH:$HOME/go/bin"
# pnpm
export PNPM_HOME="/home/brett/.local/share/pnpm"
if [[ ":$PATH:" != *":$PNPM_HOME:"* ]]; then
    export PATH="$PNPM_HOME:$PATH"
fi
# pnpm end

eval "$(zoxide init zsh)"
source <(fzf --zsh)
