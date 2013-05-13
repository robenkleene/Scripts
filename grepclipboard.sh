#!/bin/sh

usage () {
	echo "Usage: grepclipboard pattern"
}

if [[ -z "$1" ]]; then
	echo "No argument provided"
	usage
	exit 1
fi

pbpaste | grep -n -C2 $1 -