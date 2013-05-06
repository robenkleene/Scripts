#!/bin/sh

if [ -z "$1" ]; then
	echo "No file specified"
	exit 1
fi

TEMPDIRECTORY=$(mktemp -d /tmp/markdown-XXXXXX)
HTMLFILE=$TEMPDIRECTORY/markdown.html
markdown "$1" | smartypants > $HTMLFILE
echo $HTMLFILE