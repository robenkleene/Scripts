#!/usr/bin/env bash

tmp_file=$(mktemp "${TMPDIR:-/tmp}/tmux-paths.XXXX")

if [ ! -f $tmp_file ]; then
  echo "Failed to create a temp file."
  exit 1
fi

for i in $(tmux list-windows | cut -c 1); do
  for j in $(tmux list-panes -t $i | cut -d ' ' -f 7); do
    tmux run-shell -t $j "tmux display -p '#{pane_current_path}' >> $tmp_file"
  done
done
cat $tmp_file | sort --unique
rm $tmp_file
