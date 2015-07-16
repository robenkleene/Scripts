#!/bin/sh

find . -print0 | xargs -0 -n 100 stat -f"%m %Sm %N" | sort -nr | awk '{$1="";print}'