#------------------------#
#                        #
#  __      ____ _ _   _  #
#  \ \ /\ / / _` | | | | #
#   \ V  V / (_| | |_| | #
#    \_/\_/ \__,_|\__, | #
#                 |___/  #
#                        #
#------------------------#

# Open an ssh session through waypipe so graphical apps launched remotely
way() {
    if (($# != 2)); then
        echo "Usage: way <user> <host>"
        return 1
    fi

    if ! command -v waypipe &>/dev/null; then
        local os_id=$(sed -n 's/^ID=//p' /etc/os-release)
        os_id=${os_id//\"/}
        case $os_id in
        cachyos | arch) sudo pacman -S --needed waypipe ;;
        debian | ubuntu) sudo apt update && sudo apt install waypipe ;;
        fedora) sudo dnf install waypipe ;;
        *)
            printf "Unsupported OS: %s (install waypipe manually)\n" "$os_id"
            return 1
            ;;
        esac || return 1
    fi

    waypipe ssh "$1@$2"
}
