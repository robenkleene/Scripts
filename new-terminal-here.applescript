#!/usr/bin/osascript

tell application "Terminal"
	set theFolderPath to do shell script "pwd"
	do script "cd " & the quoted form of theFolderPath
end tell
return