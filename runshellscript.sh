#!/bin/sh

# Have to strip the first line if I found a command

usage () {
	echo "Runs a script passed to it by interpreting the shebang."
	echo
	echo "-e : Echo the command that would be executed to STDIN rather than running it."
}

ECHO=false
while getopts eh option
do
	case "$option"
	in
	    e)  ECHO=true
			;;
	    h)  usage
	        exit 0 
	        ;;
	    \?) echo "Invalid option or missing argument"
			usage
	        exit 1
	        ;;
	esac
done

INPUT=`cat`
SHEBANG=`echo "$INPUT" | perl -ne '/\A#!(\/.*)$/; print \$1; exit'`
if [[ -z "$SHEBANG" ]]; then
	# If no shebang was found, use sh
	SHEBANG=sh
else
	# Otherwise, strip the shebang line
	INPUT=`echo "$INPUT" | sed '1d'`
fi



# exit 1 if the input contains the SCRIPT token
if [[ $INPUT =~ SCRIPT ]]; then
    echo "ERROR: Script cannot contain the SCRIPT token."
    exit 1
fi

if $ECHO; then
	echo "$SHEBANG <<-SCRIPT"
	echo "$INPUT"
	echo "SCRIPT"
else
	$SHEBANG <<-SCRIPT
	$INPUT
	SCRIPT
fi

