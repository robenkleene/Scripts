#!/bin/bash

INSTALL_DIRECTORY_NAME="Scripts" # The name of the directory to install from.

# Stop if this is being run from any directory besides the install directory
DIRECTORY=${PWD}
DIRECTORY_NAME=${PWD##*/}
if [ ! $DIRECTORY_NAME == $INSTALL_DIRECTORY_NAME ]; then
	echo "ERROR: This directory \"$DIRECTORY_NAME\" doesn't match $INSTALL_DIRECTORY_NAME."
	echo "This script only runs from the $INSTALL_DIRECTORY_NAME directory."
	exit 1
fi

function MakeSymlink {
	FILENAME=$1
	EXECUTABLE_NAME="${FILENAME%.*}"
  DESTINATION_DIRECTORY="$DIRECTORY/bin"
	[ -d "DESTINATION_DIRECTORY" ] || mkdir "$DESTINATION_DIRECTORY"
  DESTINATION=$DESTINATION_DIRECTORY/$EXECUTABLE_NAME
	if [ -f $DESTINATION ] || [ -d $DESTINATION ]; then
		echo "$DESTINATION skipped because it already exists."
	else
		ln -s $DIRECTORY/$thisFILE $DESTINATION
	fi	
}

for thisFILE in *; do 
	# Exclude this install script and directories
 	if [[ ! $thisFILE =~ "install.sh" ]] && 
		[[ ! $thisFILE =~ "tags" ]] &&
		[ ! -d $thisFILE ]; then
		MakeSymlink $thisFILE
 	fi
done
