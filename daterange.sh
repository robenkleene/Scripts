#!/bin/bash

usage () {
  echo "Usage: daterange [-s starting modifier] [-c length of range]"
}

DATECOUNT=0
while getopts c:h: option
do
	case "$option"
	in
	    c)  DATECOUNT=$OPTARG
			;;
	    # s)  Implement starting modifier...
	    #     ;;
	    h)  usage
	        exit 0 
	        ;;
	    :)  echo "Error: -$option requires an argument" 
	        usage
	        exit 1
	        ;;
	    \?)  echo "Error: unknown option -$option" 
	        usage
	        exit 1
	        ;;
	esac
done    

if [[ $DATECOUNT -lt 1 ]]; then
	DATECOUNT=1
fi

for i in `seq 1 $DATECOUNT`
do
	DATEOFFSET=$(($i-1))
	echo `date -v+"$DATEOFFSET"d '+%m/%d/%Y'`
done