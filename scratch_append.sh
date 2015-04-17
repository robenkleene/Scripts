#!/bin/bash

cd ~/Scratch/
scratch_file=`ls -t $PWD/*.* | head -n1 | xargs echo -n`

{ echo ; echo ; cat - ; } >> "$scratch_file"