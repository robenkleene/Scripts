#!/usr/bin/env bash

for i in "$@"; do
  dir=$(dirname "$i")
  filename=$(basename "$i")
  newfilename=$(echo "$filename" | tr -dc '[:alnum:]\r\n.\-/ ' | tr -s ' ' | tr '[A-Z]' '[a-z]' | tr ' ' '-')
  newpath=$dir/$newfilename
  mv "$i" "$newpath"
done

# `tr -dc '[:alnum:]\r\n. '`: Strip non-alphanumeric characters
# `tr -s ' '`: Consolidate spaces to one space
# `tr '[A-Z]' '[a-z]'`: Lowercase
# `tr ' ' '-'`: Replace spaces with hyphens
