#!/bin/sh

DIRECTORY="$1"

if [[ -z "$DIRECTORY" ]]; then
	DIRECTORY=$(pwd)
fi

if [[ -z "$DIRECTORY" ]]; then
	echo "Error: $DIRECTORY is not a directory"
	exit 1
fi

DIRECTORY_EXPANDED="$DIRECTORY"

if [ ! -d "$DIRECTORY_EXPANDED" ]; then
	echo "Error: $DIRECTORY_EXPANDED is not a directory"
	exit 1
fi

FILE=$(mktemp "$DIRECTORY_EXPANDED/markdown-XXXXXX")
MARKDOWNFILE="$FILE.md"

if [ -f "$MARKDOWNFILE" ]; then
    echo "Error: File already exists at $MARKDOWNFILE"
	exit 1
fi

mv -n "$FILE" "$MARKDOWNFILE"

echo $MARKDOWNFILE