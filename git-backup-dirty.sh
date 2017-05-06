#!/bin/sh

backups_directory=~/Backups

eval backups_directory_expanded=${backups_directory}
if [ ! -d "$backups_directory_expanded" ]; then
    echo "Error: $backups_directory_expanded is not a directory"
    exit 1
fi

temp_directory=$(mktemp -d "$backups_directory_expanded/git-backup-XXXXXX")

git diff -z --name-only --diff-filter=UM | xargs -0 -I {} cp "{}" $temp_directory
echo $temp_directory
