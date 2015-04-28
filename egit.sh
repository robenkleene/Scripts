#!/bin/bash

EGITREPOS=~/Dotfiles/:~/Library/Services/:~/Library/Application\ Support/Avian/Bundles/Roben\ Kleene.tmbundle/:~/Library/Scripts/:~/Library/Script\ Libraries/:~/Development/Scripts/:~/Development/Snippets/:
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
	NOTHING_TO_COMMIT=false
	STATUS=$(git status)

	# Test git status message 1.
	NOTHING_TO_COMMIT_MESSAGE="nothing to commit (working directory clean)"
	test "${STATUS#*$NOTHING_TO_COMMIT_MESSAGE}" != "$STATUS" && NOTHING_TO_COMMIT=true
	# Test git status message 2.
	NOTHING_TO_COMMIT_MESSAGE="nothing to commit, working directory clean"
	test "${STATUS#*$NOTHING_TO_COMMIT_MESSAGE}" != "$STATUS" && NOTHING_TO_COMMIT=true
		
	if $NEXT ; then
		if ! $NOTHING_TO_COMMIT ; then
			pwd
			break
		fi
	else
		echo
		pwd
		git status
	fi

	if $PUSH && $NOTHING_TO_COMMIT ; then
		git push
	elif $PULL && $NOTHING_TO_COMMIT ; then
		git pull
	fi
}

function GoToDirectory {
	if [ -d "$1" ]; then
		cd "$1"
		GitProcess		
	else
		if ! $NEXT ; then # Suppress all output if not $NEXT
			echo
			echo "Directory does not exist $1"
		fi
	fi
}

for thisREPO in $REPOS; do
	GoToDirectory $thisREPO
done