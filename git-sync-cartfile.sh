#!/usr/bin/env bash

handle-github() {
  echo "git@github.com:$1.git"
}

while read LINE; do
  old_IFS=$IFS
  IFS=" "
  read -r -a columns <<< "$LINE"
  IFS=${old_IFS}
  type=${columns[0]}
  path=${columns[1]}
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
