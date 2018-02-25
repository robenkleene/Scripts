#!/usr/bin/env bash


if [[ -f "$1" ]]; then
  file_path="$1"
  dir_path=$(dirname "$1")
elif [[ -d "$1" ]]; then
  dir_path="$1"
else
  echo "$1 is not a valid file or dir_path" >&2
  exit 1
fi

# urlencode() {
#   local length="${#1}" 
#   for (( i = 0; i < length; i++ )); do
#   local c="${1:i:1}"
#   case $c in
#     [a-zA-Z0-9.~_-]) printf "$c" ;;
#     *) printf '%%%02X' "'$c"
#   esac
#   done
# }

cd "$dir_path"

commit=$(git rev-parse HEAD)

remote=$(git config --get remote.origin.url | tr -d '\n')

if [[ -n "$file_path" ]]; then
  file_subpath=$(git ls-tree --full-name --name-only HEAD "$file_path")
fi

final_url=''
if [[ $remote =~ (https://|git@)github.com[/:](.*) ]]; then
  remote_subpath="${BASH_REMATCH[2]}"
  remote_subpath=${remote_subpath%.git}
  repo_url="https://github.com/$remote_subpath"
  if [[ -z "$file_subpath" ]]; then
    final_url=$repo_url
  else
    final_url="$repo_url/blob/$commit/$file_subpath"
  fi
elif [[ $remote =~ (https://|git@)bitbucket.(com|org)[/:](.*) ]]; then
  remote_subpath="${BASH_REMATCH[3]}"
  remote_subpath=${remote_subpath%.git}
  repo_url="https://bitbucket.org/$remote_subpath"
  if [[ -z "$file_subpath" ]]; then
    final_url=$repo_url
  else
    final_url="$repo_url/src/$commit/$file_subpath"
  fi
else
  echo "$remote is not a support remote" >&2
  exit 1
fi
# encoded_url=urlencode "$final_url"
# echo $encoded_url
echo $final_url
