#!/usr/bin/env bash

sqlite3 ~/Library/Safari/History.db 'select visit_time,title from history_visits order by visit_time desc;' \
 | while read i; do d="${i%%.*}"; echo "$(date -r $((d+978307200))) | ${i#*|}"; done \
 | head -n 30
