#!/usr/bin/env bash

for dir in */; do 
  remote=$(cd "$dir" && git ls-remote --get-url 2> /dev/null)
  if (($? == 0)); then
    echo $remote
  fi
done
