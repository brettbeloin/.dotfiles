#------------------------------------------------#
#           _                        __ _        #
#   _______| |__     ___ ___  _ __  / _(_) __ _  #
#  |_  / __| '_ \   / __/ _ \| '_ \| |_| |/ _` | #
#   / /\__ \ | | | | (_| (_) | | | |  _| | (_| | #
#  /___|___/_| |_|  \___\___/|_| |_|_| |_|\__, | #
#                                         |___/  #
#                                                #
#------------------------------------------------#

#-----------------------------------------------------------------------#
#                                                                       #
#  _               ____           _   _     ____       _       _        #
# | |__  _   _ _  | __ ) _ __ ___| |_| |_  | __ )  ___| | ___ (_)_ __   #
# | '_ \| | | (_) |  _ \| '__/ _ \ __| __| |  _ \ / _ \ |/ _ \| | '_ \  #
# | |_) | |_| |_  | |_) | | |  __/ |_| |_  | |_) |  __/ | (_) | | | | | #
# |_.__/ \__, (_) |____/|_|  \___|\__|\__| |____/ \___|_|\___/|_|_| |_| #
#       |___/                                                           #
#                                                                       #
#-----------------------------------------------------------------------#

# Oh My Zsh (loaded early so the settings below override its defaults)
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="blinks"
plugins=(git)
DISABLE_AUTO_TITLE="true" # keep the custom precmd terminal title below
source $ZSH/oh-my-zsh.sh

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' ''
zstyle :compinstall filename '/home/brett/.zshrc'

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob notify

# if [[ "$PWD" == "/" ]]; then
#
#     PS1=$'%F{red}%c \n%f%F{green}%n@%m %f%D{%a %b %d %H:%M} $ '
#
# else
#
#     PS1=$'%c/ \n%n@%m %D{%a %b %d %H:%M} $ '
#
# fi

# Extract the ID line from os-release and strip out the "ID=" text
os_id=$(sed -n 's/^ID=//p' /etc/os-release)

# Strip any surrounding quotes if they exist
os_id=${os_id//\"/}

# Execute behavior based on the specific distribution
if [[ "$os_id" == "cachyos" ]]; then
    source /usr/share/wikiman/widgets/widget.zsh

    export XCURSOR_SIZE=24
elif [[ "$os_id" == "arch" ]]; then
    alias debian="distrobox enter debian"

    # if test -f ~/.config/tmux/setup/setup.sh
    #     bash    tmux kill-session
    #     bash    ~/.config/tmux/setup/setup.sh
    #
    #     if not set -q TMUX
    #         tmux a
    #     end
    # end
    #
    # if [[ -n "$TMUX" ]]; then
    #     export WAYLAND_DISPLAY=${$(tmux show-environment WAYLAND_DISPLAY)#WAYLAND_DISPLAY=}
    #     export XDG_RUNTIME_DIR=${$(tmux show-environment XDG_RUNTIME_DIR)#XDG_RUNTIME_DIR=}
    # fi

    export SWAY_UNSUPPORTED_GPU=true
else
    echo "You are running an unsupported OS: $os_id"
fi

for file in ~/.zsh/*.zsh; do
    if [[ -f "$file" ]]; then
        source "$file"
    fi
done

# add stuff to the path
export MANPAGER='nvim +Man!'
export XDG_SCREENSHOTS_DIR=~/Pictures/Screenshots/
export NODE_PATH="$HOME/.local/lib/node_modules:$NODE_PATH"
export npm_config_prefix="$HOME/.local"

# pnpm
export PNPM_HOME="/home/brett/.local/share/pnpm"
if [[ ":$PATH:" != *":$PNPM_HOME/bin:"* ]]; then
    export PATH="$PNPM_HOME/bin:$PATH"
fi
# pnpm end

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/bin/lua-language-server:$PATH"

eval "$(zoxide init zsh)"
source <(fzf --zsh)

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

if [[ -o interactive ]]; then
    # set the terminal title to the current directory
    precmd() { print -n "\e]0;$(basename "$PWD")\a"; }
    fastfetch
fi

# : ${GHCUP_INSTALL_BASE_PREFIX:=$HOME}; export PATH="$HOME/.cabal/bin:/home/brett/.ghcup/bin:$PATH" # ghcup-env

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
