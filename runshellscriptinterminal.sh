#!/bin/sh

SCRIPT=`runshellscript -e | sed 's/"/\\\"/g'`

osascript <<-APPLESCRIPT
tell application "Terminal"
	do script "$SCRIPT"
end tell
return -- Suppresses superfluous output
APPLESCRIPT