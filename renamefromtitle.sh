#!/bin/sh

for I in "$@"
do
	OLD_FILE=$I
	OLD_FILENAME=$(basename "$OLD_FILE")
	DIRECTORY=$(dirname "$OLD_FILE")

	NEW_FILENAME=$(namefromtitle "$OLD_FILE")
	if [[ $? == "0" ]]; then
		case $OLD_FILENAME in
		*.* )  
			EXTENSION="${OLD_FILENAME##*.}"
			NEW_FILENAME=$NEW_FILENAME.$EXTENSION
			;;
		esac
		NEW_FILE=$DIRECTORY/$NEW_FILENAME
		mv "$OLD_FILE" "$NEW_FILE"
	fi
done

