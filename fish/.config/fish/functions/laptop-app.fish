function laptop-app --description "Run a graphical command on the laptop, displayed here, via waypipe over ssh"
    if test (count $argv) -eq 0
        echo "usage: laptop-app <command...>" >&2
        echo "       laptop-app 'cd ~/Documents/GameEngine && ./build/GameEngine'" >&2
        return 1
    end

    # Joined so a single quoted arg like 'cd dir && ./binary' works, and so
    # does a plain 'laptop-app firefox'. Runs through sh -c on the remote
    # side since waypipe execs argv directly rather than via a shell.
    set -l remote_cmd (string join ' ' -- $argv)

    if test "$argv[1]" = firefox
        set remote_cmd "MOZ_ENABLE_WAYLAND=1 $remote_cmd"
    end

    # ssh flattens a multi-argv remote command into one string and hands it
    # to the remote login shell, so quoting must survive that as a SINGLE
    # argument here, or it gets re-split on the far end.
    set -l wrapped "sh -c '$remote_cmd'"
    waypipe ssh brett@10.102.16.135 "$wrapped"
end
