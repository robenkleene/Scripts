#!/usr/bin/env bash

for i in $(tmux list-sessions | cut -d: -f 1); do
  # tmux send -t $i tmux-banner ENTER
  tmux run-shell -t $i "tmux-banner"
done
