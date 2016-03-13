#!/usr/bin/osascript

set thePath to do shell script "pwd"
tell application "Terminal"
	do script "cd " & the quoted form of thePath
	activate
end tell
return
