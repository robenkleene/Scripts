#!/bin/sh

RUBY="rb"
LISP="el"
JAVASCRIPT="js"
COFFEESCRIPT="coffee"

usage () {
    echo "Usage: printvariable -l language -v variable"
    echo "\nLanguages:"
    echo "$RUBY : Ruby"
    echo "$LISP : Lisp"
    echo "$JAVASCRIPT : JavaScript"
    echo "$COFFEESCRIPT : CoffeeScript"
}

while getopts l:v:h option
do
    case "$option"
	in
	l)  LANGUAGE=$OPTARG
	    ;;
	v)  VARIABLE=$OPTARG
	    ;;
	h)  usage
	    exit 0 
	    ;;
	:)  usage # Error for missing value after arguement
	    exit 1
	    ;;
	\?) usage
	    exit 1
	    ;;
    esac
done

if [[ -z "$LANGUAGE" ]]; then
    echo "No language specified\n"
    usage
    exit 1
fi

if [ -z "$VARIABLE" ]; then
    # If no variable was supplied as an argument, a read one line from stdin
    read VARIABLE
fi

if [ -z "$VARIABLE" ]; then
	echo "No variable provided"
	usage
	exit 1
fi

if [ "$LANGUAGE" = "$RUBY" ]; then
    echo "puts \"$VARIABLE = \" + $VARIABLE.to_s"
    exit 0
fi

if [ "$LANGUAGE" = "$LISP" ]; then
    echo "(message \"$VARIABLE = %s\" $VARIABLE)"
    exit 0
fi

if [ "$LANGUAGE" = "$JAVASCRIPT" ]; then
    echo "console.log(\"$VARIABLE = \" + $VARIABLE)"
    exit 0
fi

if [ "$LANGUAGE" = "$COFFEESCRIPT" ]; then
    echo "console.log \"$VARIABLE = \" + $VARIABLE"
    exit 0
fi

echo "Language \"$LANGUAGE\" isn't supported"
usage
exit 1