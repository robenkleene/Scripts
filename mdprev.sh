#! /bin/sh

TEMPDIRECTORY=$(mktemp -d /tmp/markdown-XXXXXX)
TEMPFILE=$TEMPDIRECTORY/output.html
markdown "$1" | smartypants > $TEMPFILE && open $TEMPFILE
