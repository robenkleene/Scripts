#!/usr/bin/env zsh

dry_run=true
if [[ "$1" == "run" ]]; then
  dry_run=false
else
  echo "Dry Run\n"
fi

typeset -A repos

while read line; do
  old_IFS=$IFS
  IFS=" "
  # read -r -A columns <<< "$line"
  columns=(${(s: :)line})
  IFS=${old_IFS}
  echo "columns = $columns"
  remote=$columns[1]
  dir=$columns[2]

  
  echo "dir = $dir"
  echo "remote = $remote"
done < "${1:-/dev/stdin}"

# repos=(
# ~"/Development/Dotfiles/" "git@github.com:robenkleene/Dotfiles.git"
# ~"/Development/Scripts/" "git@github.com:robenkleene/Scripts.git"
# ~"/Development/Snippets/" "git@github.com:robenkleene/Snippets.git"
# ~"/Development/Archive/" "git@bitbucket.org:robenkleene/archive.git"
# ~"/Development/Settings/" "git@bitbucket.org:robenkleene/settings.git"
# ~"/Documentation/design-references/" "git@github.com:robenkleene/design-references.git"
# ~"/Documentation/development-references/" "git@github.com:robenkleene/development-references.git"
# ~"/Documentation/music-production-references/" "git@github.com:robenkleene/music-production-references.git"
# ~"/Documentation/software-references/" "git@github.com:robenkleene/software-references.git"
# ~"/Development/Scratch/" "git@bitbucket.org:robenkleene/scratch.git"
# )

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
