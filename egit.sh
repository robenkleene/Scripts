#!/bin/bash

IFS=:
REPOS=${EGITREPOS?"EGITREPOS is not set"}

usage () {
	echo "Usage: egit [-pln]"
	echo
	echo "EGITREPOS environment variable defines witch directories to check."
	echo
	echo "No flags just lists the status of each repo."
	echo "-p : Push all repos without staged changes"
	echo "-l : Pull all repos without staged changes"
	echo "-n : Print next directory path with unstaged changes"
}

PUSH=false
PULL=false
NEXT=false
while getopts plnh option
do
	case "$option"
	in
	    p)  PUSH=true
			;;
	    l)  PULL=true
			;;
	    n)  NEXT=true
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

function GitProcess {
	NOT_STAGED=false
	STATUS=$(git status)
	NOT_STAGED_MESSAGE="Changes not staged for commit"
	test "${STATUS#*$NOT_STAGED_MESSAGE}" != "$STATUS" && NOT_STAGED=true
		
	if $NEXT ; then
		if $NOT_STAGED; then
			# Git Test
			echo $(pwd) # No idea why this is necessary to wrap in echo, but script sometimes fails otherwise
			break
		fi
	else
		echo
		pwd
		git status
	fi

	if $PUSH && ! $NOT_STAGED ; then
		git push
	elif $PULL && ! $NOT_STAGED ; then
		git pull
	fi
}

function GoToDirectory {
	if [ -d "$1" ]; then
		cd "$1"
		GitProcess		
	else
		echo "Directory does not exist $1"
		echo
	fi
}

for thisREPO in $REPOS; do
	GoToDirectory $thisREPO
done