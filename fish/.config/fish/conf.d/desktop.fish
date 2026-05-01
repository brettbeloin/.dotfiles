if status is-login
    if test (tty) = /dev/tty1
        exec dbus-run-session sway
    end
end

