#!/usr/bin/env bash

set -e

recursive=false
include_dir=false
while getopts ":rh" option
  do case "$option" in
    r)
      recursive=true
      include_dir=true
      ;;
    d)
      include_dir=true
      ;;
    h)
      echo "Usage: git-sync-remotes [-hr]"
      exit 0
      ;;
    :)
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

recurse_directory() {
  cd "$1"
  for dir in */; do 
    # If there's not directory bash sets `$dir` to `*/` for some reason
    if [[ $dir != "*/" ]] ; then
      process_directory "$dir"
    fi
  done
  cd .. >/dev/null
}

process_directory() {
  set +e
  remote=$(cd "$1" && git ls-remote --get-url 2> /dev/null)
  status=$?
  set -e
  if ((status == 0)); then
    output=$remote
    if $include_dir; then
      output="$remote \"$1\""
    fi
    echo $output
  else
    if $recursive; then
      recurse_directory "$1"
    fi
  fi
}

recurse_directory .
