#!/bin/bash

cd ~/Scratch/
scratch_file=`ls -t $PWD/*.* | head -n1 | xargs echo -n`

read first_line

{ echo ; echo $first_line; cat - ; } >> "$scratch_file"

# TODO This will fail if `$first_line` has characters that need to be escaped

osascript -e "display notification \"$first_line\" with title \"Append to Scratch\""