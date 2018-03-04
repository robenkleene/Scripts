#!/usr/bin/env bash

sqlite3 -separator $'\t' ~/Library/Safari/History.db \
  'SELECT title, url FROM history_visits INNER JOIN history_items ON history_visits.history_item = history_items.id ORDER BY visit_time desc LIMIT 1000;' \
  | uniq
