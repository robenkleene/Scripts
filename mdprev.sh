#!/bin/bash

USAGE="\
usage: $0 [-msl] file

-m : Marked
-s : Safari
-l : Lynx
"

usage () {
        echo "$USAGE"
}

MARKED_FLAG=false
SAFARI_FLAG=false
LYNX_FLAG=false

if [ $# -ne 2 ] ; then
	# Set Default
	usage
	exit 1
fi

while getopts ":msl" option; do
	case $option in
		m)	MARKED_FLAG=true
			;;
		s)	SAFARI_FLAG=true
			;;
		l)	LYNX_FLAG=true
			;;
		?) 	echo "Error: unknown option -$option" 
			usage
			exit 1
			;;
	esac
done


if $MARKED_FLAG ; then
	open -a "Marked.app" $2
elif $LYNX_FLAG ; then
	markdown $2 | smartypants | lynx -stdin
elif $SAFARI_FLAG ; then
	TEMPDIRECTORY=$(mktemp -d /tmp/markdown-XXXXXX)
	HTMLFILE=$TEMPDIRECTORY/markdown.html
	markdown $2 | smartypants > $HTMLFILE
	open $HTMLFILE
# Below Doesn't work yet
#	JSFILE=$TEMPDIRECTORY/markdown.js
#	echo "window.open('file://$HTMLFILE','_blank','titlebar=0');" > $JSFILE
#
#	osascript <<-APPLESCRIPT
#set theJavaScriptFile to "$JSFILE"
#set theJavaScript to read theJavaScriptFile
#tell application "Safari"
#	activate
#	do JavaScript theJavaScript in document 1
#end tell
#return -- Suppresses superfluous output
#	APPLESCRIPT
fi
