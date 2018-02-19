#!/usr/bin/env bash

EGITREPOS=~/Development/Dotfiles/:~/Development/Scripts/:~/Development/Snippets/:~/Development/Archive/:~/Development/Settings/:~/Documentation/design-references/:~/Documentation/development-references/:~/Documentation/music-production-references/:~/Documentation/software-references/:~/Development/Scratch/

if [ "$(uname)" == "Darwin" ]; then
  EGITREPOS=$EGITREPOS:~/Library/Services/:~/Library/Application\ Support/TextMate/Bundles/Roben\ Kleene.tmbundle/:~/Library/Scripts/:~/Library/Script\ Libraries/
fi

IFS=':' read -ra repos <<< "$EGITREPOS"

command_name="egit"

source ~/Development/Scripts/nobin/_giterator.sh

for repo in "${repos[@]}"; do
  go_to_directory $repo
done
