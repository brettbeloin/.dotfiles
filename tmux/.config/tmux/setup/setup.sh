#!/usr/bin/env bash

SESH="Arch Desktop"

# Check if the session already exists
if ! tmux has-session -t "$SESH" 2>/dev/null; then
  # Create the session with first window
  tmux new-session -ds "$SESH" -n "Editor"
  tmux send-keys -t "$SESH:Editor" "cd ~/Documents/" C-m

  tmux new-window -t "$SESH" -n "Server"

  tmux new-window -t "$SESH" -n "Home"
fi
