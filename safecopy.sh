#!/bin/sh

if [ "$(uname)" == "Darwin" ]; then
	pbcopy $@
else
	# `true` is no-op
	true
fi

