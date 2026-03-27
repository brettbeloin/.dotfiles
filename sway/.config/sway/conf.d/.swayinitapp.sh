#!/usr/bin/env bash
set -e

if ! pgrep ghostty >/dev/null; then echo "Launching ghostty..." && swaymsg "exec /usr/bin/ghostty"; fi
if ! pgrep alacritty >/dev/null; then echo "Launching alacritty..." && swaymsg "exec /usr/bin/alacritty"; fi
if ! pgrep chrome >/dev/null; then echo "Launching chrome..." && swaymsg "exec flatpak run com.google.Chrome"; fi
if ! pgrep steam >/dev/null; then echo "Launching steam..." && swaymsg "exec /usr/bin/steam"; fi
# if ! pgrep Discord >/dev/null; then echo "Launching discord..." && swaymsg "exec flatpak run com.discordapp.Discord"; fi
