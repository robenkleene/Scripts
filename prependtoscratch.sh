#!/bin/sh

SCRATCHFILE=~/Dropbox/Text/Scratch.md

TEMPFILE=$(mktemp /tmp/File-XXXXXX)
{ cat - ; echo ; } | cat - $SCRATCHFILE > $TEMPFILE && mv $TEMPFILE $SCRATCHFILE