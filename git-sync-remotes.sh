#!/usr/bin/env bash

set -e
find . -type d -execdir test -d "{}/.git" \; -print -prune | while read dir; do
  url=$(cd "$dir" && git ls-remote --get-url)
  echo "$url \"$dir\""
done
