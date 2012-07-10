#!/bin/bash

TEMPFILE=$(mktemp /tmp/RunJavaScript-XXXXXX)
cat > "$TEMPFILE"

osascript <<-APPLESCRIPT
	set theBookmarkletFile to "$TEMPFILE"
	set theJavaScript to read theBookmarkletFile
	tell application "Safari"
		do JavaScript theJavaScript in document 1
	end tell
	return -- Suppresses superfluous output
APPLESCRIPT
