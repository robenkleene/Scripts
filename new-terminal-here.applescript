#!/usr/bin/osascript

tell application "Terminal"
	set theFolderPath to do shell script "pwd"
	do script "cd " & theFolderPath
end tell
return