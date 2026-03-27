# Sway autostart on TTY1
if status is-login
    if test (tty) = /dev/tty1
        exec dbus-run-session sway
    end
end

if test -f ~/.setup.sh
    bash .setup.sh

    if not set -q TMUX
        tmux a
    end
end

set fish_greeting

set -gx XCURSOR_THEME WinSur-dark-cursors
set -gx XCURSOR_SIZE 24

# my custom aliases
alias sysEdit='nvim ~/.config/fish/config.fish && source ~/.config/fish/config.fish'
alias sysRead='cat ~/.config/fish/config.fish'
alias sysOff='sudo zzz'
alias reboot="loginctl reboot"
alias vim='nvim'
alias gEmacs='emacsclient -c -a "nvim"'
alias tEmacs='emacsclient -t -a "nvim"'
alias df="df -h"
alias lsblk="lsblk -lf"
alias pkgSearch="xbps-query -Rs"
alias search="xbps-query -S"
alias trm="trash -v"
alias cd="z"
alias pacman="sudo xbps-install -S"

zoxide init fish | source
fzf --fish | source

set -gx XDG_SCREENSHOTS_DIR ~/Pictures/Screenshots/
fish_add_path ~/.cargo/bin/
# fish_add_path ~/.config/emacs/bin/
fish_add_path ~/.local/bin
set -gx NODE_PATH $HOME/.local/lib/node_modules $NODE_PATH
set -gx npm_config_prefix $HOME/.local
set -gx PATH $PATH $HOME/go/bin

# pnpm
set -gx PNPM_HOME "/home/brett/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
