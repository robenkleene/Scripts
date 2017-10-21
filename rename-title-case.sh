#!/usr/bin/env bash

for i in "$@"; do
  filename=$(basename "$i")
  filename_no_ext=${filename%.*}
  if [[ $filename_no_ext =~ ^[a-z0-9-]*$ ]]; then
    # If the filename contains only lowercase letters and hyphens then assume
    # convert it to title case with spaces.
    script_dir=$(dirname $0)
    title=$(echo $filename_no_ext | tr "-" " " | $script_dir/title-case)
    extension="${filename##*.}"
    newfilename=$title.$extension
    dir=$(dirname "$i")
    newpath=$dir/$newfilename
    mv -n "$i" "$newpath"
  fi
done
