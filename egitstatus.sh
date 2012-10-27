#!/bin/bash

function GitStatus {
	cd "$1"
	pwd
	git status
	echo
}

GitStatus ~/Development/LaunchAgents
GitStatus ~/Dotfiles/
GitStatus ~/Library/Services/
GitStatus ~/Library/Application\ Support/Avian/Bundles/Roben.tmbundle/
GitStatus ~/Library/Scripts/
GitStatus ~/Development/Scripts/
GitStatus ~/Development/Snippets/
GitStatus ~/Development/Bookmarklets/
GitStatus ~/Development/Bookmarklets/