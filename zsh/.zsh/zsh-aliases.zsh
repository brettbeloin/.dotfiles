#-------------------------------------------------------#
#           _             _ _                           #
#   _______| |__     __ _| (_) __ _ ___ ___  ___  ___   #
#  |_  / __| '_ \   / _` | | |/ _` / __/ __|/ _ \/ __|  #
#   / /\__ \ | | | | (_| | | | (_| \__ \__ \  __/\__ \  #
#  /___|___/_| |_|  \__,_|_|_|\__,_|___/___/\___||___/  #
#                                                       #
#-------------------------------------------------------#

alias sysEdit='nvim ~/.zshrc && source ~/.zshrc'
alias sysRead='cat ~/.zshrc'
alias sysExplore="sudo ncdu /"
alias orphan='sudo pacman -Rns $(pacman -Qtdq)'
alias vim='nvim'
alias gEmacs='emacsclient -c -a "nvim"'
alias tEmacs='emacsclient -t -a "nvim"'
alias df="df -h"
alias poweroff="sudo systemctl poweroff"
alias reboot="sudo systemctl reboot"
alias lsblk="lsblk -lf"
alias ls="ls -Ax --color=auto"
alias ll="ls -lAh --color=auto"
alias rm="rm -rf"
alias mkdir="mkdir -pv"
alias trm="trash -v"
alias cd="z"
alias ..="cd .."
alias 2b="cd ../.."
alias 3b="cd ../../.."
alias 4b="cd ../../../../"
alias 5b="cd ../../../../../"
alias cc="clang"
alias cc++="clang++"
alias pkgSearch="pacman -Qi"
alias search="pacman -Ss"
alias vcpkg="~/vcpkg/vcpkg "
alias open="xdg-open"

# Toggle the compose project in the current directory: down if running, up otherwise.
# unalias composeUp 2>/dev/null
compose() {
    if [[ -n "$(docker compose ps -q --status running 2>/dev/null)" ]]; then
        echo "Compose is up — bringing it down..."
        docker compose down "$@"
    else
        echo "Compose is down — bringing it up..."
        docker compose up --build -d "$@"
    fi
}

# Run a command on the NVIDIA dGPU via PRIME render offload, e.g.
# `nvidia-offload steam` or a per-game Steam launch option:
# __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only %command%
alias nvidia-offload="env __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only "
