#!/usr/bin/env bash

while IFS= read -r -d '' i ; do
  cd "$i"
  # echo $i
  $@
  # echo
done < <(tmux-paths -0)
