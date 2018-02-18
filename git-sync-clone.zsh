#!/usr/bin/env zsh

dry_run=true
if [[ "$1" == "run" ]]; then
  dry_run=false
else
  echo "Dry Run\n"
fi


exit 0

for directory in "${(@k)repos}"; do
  remote="$repos[$directory]"
  # Test it's a directory
  if [[ -d "$directory" ]]; then
    current=$(cd "$directory"; git ls-remote --get-url | tr -d '\n')
    # Test that it can get the remote
    if (($? > 0)); then
      echo "ERROR: Failed to get the git remote URL at $directory"
    else
      # Test that the remote is accurate
      if [[ "$current" != "$remote" ]]; then
        echo "current = $current"
        echo "remote = $remote"
        echo "ERROR: The remote does not match $remote in $directory"
      else
        echo "The remote is correct for $directory"
      fi
    fi
  else
    echo "Cloning $remote into $directory"
    if ! $dry_run; then
      git clone $remote "$directory"
    fi
    if (($? > 0)); then
      echo "ERROR: Failed cloning $remote into $directory"
    fi
  fi
done
