#!/usr/bin/env bash

tmux-paths -0 | xargs -0 rg --smart-case --line-number $1
