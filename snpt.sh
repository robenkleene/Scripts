#!/bin/sh

SNIPPETS_DIRECTORY=~/Development/Snippets

eval SNIPPETS_DIRECTORY_EXPANDED=${SNIPPETS_DIRECTORY}
if [ ! -d "$SNIPPETS_DIRECTORY_EXPANDED" ]; then
    echo "Error: $SNIPPETS_DIRECTORY_EXPANDED is not a directory"
    exit 1
fi

usage () {
    echo "Usage: snpt [-l language] snippet"
}

while getopts l:h option
do
    case "$option"
	in
	l)  LANGUAGE=$OPTARG
	    ;;
	h)  usage
	    exit 0 
	    ;;
	:)  usage # Error for missing value after arguement
	    exit 1
	    ;;
	\?) usage
	    exit 1
	    ;;
    esac
done

if [[ -z "$LANGUAGE" ]]; then
    SNIPPET=$1
else
    SNIPPET=$3
fi

if [ -z "$SNIPPET" ]; then
    # If no snippet was supplied as an argument, a read one line from stdin
    read SNIPPET
fi

if [[ ! -z "$LANGUAGE" ]]; then
    SNIPPET=$SNIPPET.$LANGUAGE
fi


MATCH=$(find $SNIPPETS_DIRECTORY -iname "$SNIPPET" -print -quit)

if [ -z "$MATCH" ]; then
	echo "No snippet found for \"$SNIPPET\""
	exit 1
fi

cat "$MATCH"
