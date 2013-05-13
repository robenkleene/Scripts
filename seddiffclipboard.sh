#!/bin/sh

usage () {
	echo "Usage: seddiffclipboard s/search/replace/"
}

if [[ -z "$1" ]]; then
	echo "No argument provided"
	usage
	exit 1
fi

pbpaste | seddiff $1