#!/usr/bin/env bash

if [[ -f "$1" ]]; then
  echo " is a file"
elif [[ -d "$1" ]]; then
  echo "$1 is a directory"
else
  exit 1
fi

