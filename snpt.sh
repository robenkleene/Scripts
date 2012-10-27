#!/bin/sh

SNIPPETS_DIRECTORY=~/Development/Snippets

eval SNIPPETS_DIRECTORY_EXPANDED=${SNIPPETS_DIRECTORY}
if [ ! -d "$SNIPPETS_DIRECTORY_EXPANDED" ]; then
	echo "Error: $SNIPPETS_DIRECTORY_EXPANDED is not a directory"
	exit 1
fi

MATCH=$(find $SNIPPETS_DIRECTORY -iname "$1" -print -quit)

if [ -z "$MATCH" ]; then
	echo "No snippet found for \"$1\""
	exit 1
fi

cat "$MATCH"