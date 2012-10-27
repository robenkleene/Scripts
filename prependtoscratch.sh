#!/bin/sh

SCRATCHFILE=~/Dropbox/Documents/Text/Scratch.md

TEMPFILE=$(mktemp /tmp/File-XXXXXX)
{ cat - ; echo ; } | cat - $SCRATCHFILE > $TEMPFILE && mv $TEMPFILE $SCRATCHFILE