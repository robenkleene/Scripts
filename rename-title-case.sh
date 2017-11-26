#!/usr/bin/env bash 

set -e

for i in "$@"; do
  filename=$(basename "$i")
  filename_no_ext=${filename%.*}
  if [[ $filename_no_ext =~ ^[a-z0-9-]*$ ]]; then
    # If the filename contains only lowercase letters and hyphens then assume
    # convert it to title case with spaces.
    script_dir=$(dirname $0)
    title=$(echo $filename_no_ext | tr "-" " " | $script_dir/title-case)
    if [ "$filename_no_ext" == "$filename" ]; then
      # If there was no extension (e.g., common for folders) the name just
      # equals the title
      newfilename=$title
    else
      # If there is an extension, re-add it
      extension="${filename##*.}"
      newfilename=$title.$extension
    fi
    dir=$(dirname "$i")
    newpath=$dir/$newfilename
    tmppath=$(mktemp "$newpath.XXXXXX")
    # First move to a temp path, this allows capitalizing single word filenames
    # which would otherwise fail because of macOS case-sensitive file system
    # issues
    if [ -d "$i" ]; then
      # If it's a directory, first delete the `$tmppath`, otherwise the `mv`
      # will fail because you can't move a directory onto a file.
      # (Note that for files we create the `$tmppath` and then just overwrite
      # it, which is a bit unintuitive.)
      rm "$tmppath"
    fi
    mv "$i" "$tmppath"
    mv -n "$tmppath" "$newpath"
  fi
done
