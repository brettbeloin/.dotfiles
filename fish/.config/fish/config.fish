# Sway autostart on TTY1

# if status is-login
#     if test (tty) = /dev/tty1
#         if test -f ~/.config/fish/conf.d/laptop.conf
#             exec dbus-run-session sway --unsupported-gpu
#         else
#             exec dbus-run-session sway
#         end
#     end
# end

# Extract the ID line from os-release and strip out the "ID=" text
set -l os_id (string match -r '^ID=(.+)' < /etc/os-release)[2]

# Strip any surrounding quotes if they exist
set os_id (string trim -c '"' $os_id)

# Execute behavior based on the specific distribution
if test "$os_id" = "cachyos"
    echo "You are running CachyOS (Arch-based)"
    # Add your pacman/paru aliases or configuration here
    source /usr/share/wikiman/widgets/widget.fish

    set -gx XCURSOR_SIZE 24

    alias poweroff="sudo loginctl poweroff"
    alias reboot="sudo loginctl reboot"
    alias pkgSearch="pacman -Qi"
    alias search="pacman -Ss"

else if test "$os_id" = "fedora"
    echo "You are running Fedora (RPM-based)"
    # Add your dnf aliases or configuration here
    alias poweroff="sudo systemctl poweroff"
    alias reboot="sudo systemctl reboot"
    alias pkgSearch="dnf info"
    alias search="dnf search --all"

else
    echo "You are running an unsupported OS: $os_id"
end


# if test -f ~/.setup.sh
#     bash .setup.sh
#
#     if not set -q TMUX
#         tmux a
#     end
# end

# add stuff to the path
set fish_greeting
set -gx MANPAGER 'nvim +Man!'
set -gx NODE_PATH $HOME/.local/lib/node_modules $NODE_PATH
set -gx npm_config_prefix $HOME/.local
set -gx PATH $PATH $HOME/go/bin
# pnpm
set -gx PNPM_HOME "/home/brett/.local/share/pnpm"
if not string match -q -- "$PNPM_HOME/bin" $PATH
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end


fish_add_path ~/.cargo/bin/
fish_add_path /usr/local/go/bin
fish_add_path ~/.config/emacs/bin/
fish_add_path ~/.local/bin
fish_add_path /home/linuxbrew/.linuxbrew/bin/lua-language-server

# my custom aliases
alias sysEdit='nvim ~/.config/fish/config.fish && source ~/.config/fish/config.fish'
alias sysRead='cat ~/.config/fish/config.fish'
alias vim='nvim'
alias gEmacs='emacsclient -c -a "nvim"'
alias tEmacs='emacsclient -t -a "nvim"'
alias df="df -h"
alias lsblk="lsblk -lf"
alias ls="ls -lh --color=auto"
alias la="ls -lAh --color=auto"
alias rm="rm -r"
alias mkdir="mkdir -pv"
alias cd="z"
alias ..="cd .."
alias 2b="cd ../.."
alias 3b="cd ../../.."
alias 4b="cd ../../../../"
alias 5b="cd ../../../../../"
alias vcpkg="~/vcpkg/vcpkg "

zoxide init fish | source
fzf --fish | source

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"

if status --is-interactive
    # set the terminal title to the current directory
    function fish_title
        echo (basename (pwd))
    end
    fastfetch
end
