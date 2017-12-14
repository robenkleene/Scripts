#!/usr/bin/env bash

for i in $(tmux list-sessions -F "#{?session_attached,#S,}" | grep .); do
  # tmux send -t $i tmux-banner ENTER
  tmux run-shell -t $i "tmux-banner"
done
