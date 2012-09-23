#!/bin/sh

set -e

OLD_FILE=$1
OLD_FILENAME=$(basename "$1")
DIRECTORY=$(dirname "$1")

NEW_FILENAME=$(namefromtitle "$1")
case $OLD_FILENAME in
*.* )  
	EXTENSION="${OLD_FILENAME##*.}"
	NEW_FILENAME=$NEW_FILENAME.$EXTENSION
	;;
esac
NEW_FILE=$DIRECTORY/$NEW_FILENAME

mv "$OLD_FILE" "$NEW_FILE"
