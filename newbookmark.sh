#!/bin/sh

# DIRECTORY="/Users/robenkleene/Development/Scratch/Shell/newbookmark/output"
# RENAME="/Users/robenkleene/Development/Scripts/namefromtitle.pl"

DIRECTORY="$HOME/Dropbox/Text/Inbox"
RENAME="$HOME/Development/Scripts/namefromtitle.pl"

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
cat > $FILE

NEWNAME=$($RENAME "$FILE")
MARKDOWNFILE="$(dirname $FILE)/$NEWNAME.md"

if [ -f "$MARKDOWNFILE" ]; then
  echo "Error: File already exists at $MARKDOWNFILE"
  exit 1
fi

mv -n "$FILE" "$MARKDOWNFILE"
open "$MARKDOWNFILE"