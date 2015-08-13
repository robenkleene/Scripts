#!/bin/sh

usage () {
	echo "Usage: afar [-ef] command"
	echo
	echo "-e : Execute the find and replace"
	echo "-f : List files that will be matched"
}

execute_command=false
list_files=false

while [ $# -gt 0 ]; do
  while getopts "efh" opt; do
    case "$opt" in
      e) execute_command=true;;
      f) list_files=true;;
	  h) usage
	  exit 0;;
      \?) echo "Invalid option or missing argument"
	  usage
	  exit 1;;
    esac
    shift
    OPTIND=1
  done
  if [ $# -gt 0 ]; then
    non_option_arguments=(${non_option_arguments[@]} $1)
    shift
    OPTIND=1
  fi
done

if $list_files ; then
	ack -f
	exit 0
fi

if $execute_command ; then
	export execute_flag="-i ''"
else
	export preview_flag=" | git diff --no-index -- \"\$f\" -"
fi

export substitution_command=${non_option_arguments[0]}

if [ -z $substitution_command ]; then
	usage
	exit 1
fi

full_command="export f=\"{}\"; sed $execute_flag $substitution_command \"\$f\" $preview_flag"
ack -f --print0 | xargs -0 -I {} sh -c "$full_command"