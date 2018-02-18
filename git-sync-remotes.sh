#!/usr/bin/env bash

url=''
path=''
url_line=true
find . -name .git -type d -prune \
  -execdir git ls-remote --get-url \; \
  -exec dirname {} \; | while read line; do
  if $url_line; then
    url=$line
    url_line=false
  else
    path=$line
    echo "$url \"$path\""
    url_line=true
  fi
done
