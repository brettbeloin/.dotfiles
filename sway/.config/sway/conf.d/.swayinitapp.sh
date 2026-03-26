#!/usr/bin/env bash
set -e

if ! pgrep ghostty >/dev/null; then echo "Launching ghostty..." && swaymsg "exec /usr/bin/ghostty"; fi
if ! pgrep alacritty >/dev/null; then echo "Launching alacritty..." && swaymsg "exec /usr/bin/alacritty"; fi
if ! pgrep falkon >/dev/null; then echo "Launching falkon..." && swaymsg "exec /usr/bin/falkon"; fi
if ! pgrep steam >/dev/null; then echo "Launching steam..." && swaymsg "exec /usr/bin/steam"; fi
