#!/bin/sh

FILENAME=$(basename "$1")
FILENAMENOEXT=${FILENAME%.*}
echo "# $FILENAMENOEXT"
echo