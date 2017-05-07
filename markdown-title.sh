#!/bin/sh

filename=$(basename "$1")
filename_no_ext=${filename%.*}
if [[ $filename_no_ext =~ [a-z-]* ]]; then
  # If the filename contains no uppercase letters than assume it's a lowercase,
  # hypenated filename and convert it to title case with spaces.
  title=$(echo $filename_no_ext | tr "-" " " | title-case)
fi
echo "# $title"
echo
