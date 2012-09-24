#!/bin/bash

if [ -z "$TEXT_INBOX" ]; then
	echo "Error: TEXT_INBOX is not set"
	exit 1
fi

eval TEXT_INBOX_EXPANDED=${TEXT_INBOX}
if [ ! -d "$TEXT_INBOX_EXPANDED" ]; then
	echo "Error: $TEXT_INBOX is not a directory."
	exit 1
fi

TEXTFILE=$(mktemp $TEXT_INBOX_EXPANDED/inbox-XXXXXX)
echo $TEXTFILE
