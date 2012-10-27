#!/bin/sh

BACKUP_DIRECTORY="~/Backups"

eval BACKUP_DIRECTORY_EXPANDED=${BACKUP_DIRECTORY}
if [ ! -d "$BACKUP_DIRECTORY_EXPANDED" ]; then
	echo "Error: $BACKUP_DIRECTORY_EXPANDED is not a directory"
	exit 1
fi

TEMPFILE=$(mktemp $BACKUP_DIRECTORY_EXPANDED/ArchivedText-XXXXXX)
TEMPFILETXT=$TEMPFILE.txt

if [ -f $TEMPFILETXT ]; then
    echo "Error: File already exists at $TEMPFILETXT"
	exit 1
fi

mv -n $TEMPFILE $TEMPFILETXT

cat >> $TEMPFILETXT