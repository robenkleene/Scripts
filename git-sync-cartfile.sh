#!/usr/bin/env bash

handle-github() {
  echo "git@github.com:$1.git"
}

while read line; do
  old_IFS=$IFS
  IFS=" "
  read -r type path <<< "$line"
  IFS=${old_IFS}
  # Strip quotes
  path="${path%\"}"
  path="${path#\"}"

  case "$type" in
    "github")
      handle-github $path
      ;;
    *)
      echo "$type isn't supported"
      exit 1
      ;;
  esac
done < /dev/stdin
