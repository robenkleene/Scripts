#!/bin/sh

usage () {
	echo "Usage: seddiff s/search/replace/"
}

if [[ -z "$1" ]]; then
	echo "No argument provided"
	usage
	exit 1
fi

TEMPFILE=$(mktemp /tmp/seddiff-XXXXXX)
cat > "$TEMPFILE"

sed $1 $TEMPFILE | diff -u $TEMPFILE - | colordiff