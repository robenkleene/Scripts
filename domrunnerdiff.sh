#!/bin/sh

TEMPFILE=$(mktemp /tmp/domrunnerdiff-XXXXXX)
trap "rm '$TEMPFILE'" EXIT
domrunner "$@" -o > "$TEMPFILE"
domrunner "$@" | diff -u $TEMPFILE - | colordiff