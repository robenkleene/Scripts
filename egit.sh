#!/usr/bin/env bash

EGITREPOS=~/Development/Dotfiles/:~/Development/Scripts/:~/Development/Snippets/:~/Development/Archive/:~/Development/Settings/:~/Documentation/design-references/:~/Documentation/development-references/:~/Documentation/music-production-references/:~/Documentation/software-references/:~/Development/Scratch/

if [ "$(uname)" == "Darwin" ]; then
  EGITREPOS=$EGITREPOS:~/Library/Services/:~/Library/Application\ Support/TextMate/Bundles/Roben\ Kleene.tmbundle/:~/Library/Scripts/:~/Library/Script\ Libraries/
fi

IFS=':' read -ra repos <<< "$EGITREPOS"

usage () {
  echo "Usage: egit [-pln]"
  echo
  echo "EGITREPOS environment variable defines witch directories to check."
  echo
  echo "No flags just lists the status of each repo."
  echo "-p : Push all repos without staged changes"
  echo "-l : Pull all repos without staged changes"
  echo "-n : Print next directory path with unstaged changes"
}

push=false
pull=false
next=false
while getopts "plnh" option
  do case "$option" in
    p)
      push=true
      ;;
    l)
      pull=true
      ;;
    n)
      next=true
      ;;
    h)
      usage
      exit 0
      ;;
    \?)
      echo "Invalid option or missing argument"
      usage
      exit 1
      ;;
  esac
done

function GitProcess {
  if ! [[ -d ".git" ]]; then
    return
  fi
  nothing_to_commit=false
  STATUS=$(git status)

  # Test git status message 1.
  NOTHING_TO_COMMIT_MESSAGE="nothing to commit (working directory clean)"
  test "${STATUS#*$NOTHING_TO_COMMIT_MESSAGE}" != "$STATUS" && nothing_to_commit=true
  # Test git status message 2.
  NOTHING_TO_COMMIT_MESSAGE="nothing to commit, working directory clean"
  test "${STATUS#*$NOTHING_TO_COMMIT_MESSAGE}" != "$STATUS" && nothing_to_commit=true
  # Test git status message 3.
  NOTHING_TO_COMMIT_MESSAGE="nothing to commit, working tree clean"
  test "${STATUS#*$NOTHING_TO_COMMIT_MESSAGE}" != "$STATUS" && nothing_to_commit=true


  if $next; then
    if ! $nothing_to_commit; then
      pwd
      break
    fi
  else
    echo
    pwd
    git status
  fi

  if $push && $nothing_to_commit; then
    git push
  elif $pull && $nothing_to_commit; then
    git pull
  fi
}

function go_to_directory {
  if [ -d "$1" ]; then
    cd "$1"
    GitProcess
  else
    if ! $next ; then # Suppress all output if not $next
      echo
      echo "Directory does not exist $1"
    fi
  fi
}

for repo in "${repos[@]}"; do
  go_to_directory $repo
done

