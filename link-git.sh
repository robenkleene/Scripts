#!/usr/bin/env bash

if [[ -f "$1" ]]; then
  filename="$1"
  directory=$(dirname "$1")
elif [[ -d "$1" ]]; then
  directory="$1"
else
  echo "$1 is not a valid file or directory" >&2
  exit 1
fi

remote=$(git config --get remote.origin.url | tr -d '\n')

if $(echo $remote | grep \
  --extended-regexp \
  --only-matching \
  --ignore-case \
  --quiet \
  '(https://|git@)github.com[/:]'); then
  echo "GitHub"
elif $(echo $remote | grep \
  --extended-regexp \
  --only-matching \
  --ignore-case \
  --quiet \
  '(https://|git@)bitbucket.(com|org)[/:]'); then
  echo "Bitbucket"
fi

# git config --get remote.origin.url

# https://github.com


# github_url = "https://github.com/#{github_subpath}"

# cd directory && git rev-parse HEAD

# cd directory && git ls-tree --full-name --name-only HEAD #{Shellwords.escape(filename)}

# cd directory && git config --get remote.origin.url | cut -f2 -d: | cut -f1 -d.


# github_subpath = URI.escape("#{repo_path}/blob/#{commit}/#{file_path}")
# github_url = "https://github.com/#{github_subpath}"

