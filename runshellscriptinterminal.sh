#!/bin/sh

SCRIPT=`runshellscript -e | sed 's/"/\\\"/g'`

if [[ $SCRIPT =~ "ERROR: Script cannot contain the SCRIPT token." ]]; then
    echo "ERROR: Script cannot contain the SCRIPT token."
    exit 1
fi

osascript <<-APPLESCRIPT
tell application "Terminal"
	do script "$SCRIPT"
	activate
end tell
return -- Suppresses superfluous output
APPLESCRIPT