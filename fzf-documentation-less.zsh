#!/usr/bin/env zsh

source ~/Development/Scripts/nobin/_fzf-inline-result.sh

cd ~/Documentation/
local result=$(_fzf-inline-result)
if [[ -n $result ]]; then
  parameter=$(printf '%q' "$PWD/$result")
  final_cmd="cat $parameter | less -FX"
  eval $final_cmd
  if [ $? -eq 0 ]; then
    # Add to history
    print -sr $final_cmd
  fi
fi
