#!/bin/sh

SNIPPETS_DIRECTORY=~/Development/Snippets

eval SNIPPETS_DIRECTORY_EXPANDED=${SNIPPETS_DIRECTORY}
if [ ! -d "$SNIPPETS_DIRECTORY_EXPANDED" ]; then
	echo "Error: $SNIPPETS_DIRECTORY_EXPANDED is not a directory"
	exit 1
fi

if [ -z "$1" ]; then
	# If no arguement is supplied read one line from stdin
	read TEMPLATE
else
	TEMPLATE=$1
fi

MATCH=$(find $SNIPPETS_DIRECTORY -iname "$TEMPLATE" -print -quit)

if [ -z "$MATCH" ]; then
	echo "No snippet found for \"$TEMPLATE\""
	exit 1
fi

cat "$MATCH"