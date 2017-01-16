#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
	pbcopy $@
else
	cat >/dev/null
fi

