#!/usr/bin/env bash

text=`cat`
printf "%q" $text | automator -i - ~/Library/Services/Backup\ Text.workflow
