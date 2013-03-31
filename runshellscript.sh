#!/bin/sh

INPUT=`cat`
COMMAND=`echo "$INPUT" | perl -ne '/\A#!(\/.*)$/; print \$1; exit'`
if [[ -z "$COMMAND" ]]; then
	COMMAND=sh
fi

# exit 1 if the input contains the SCRIPT token
if [[ $INPUT =~ SCRIPT ]]; then
    echo "ERROR: Script cannot contain the SCRIPT token."
    exit 1
fi

$COMMAND <<-SCRIPT
$INPUT
SCRIPT