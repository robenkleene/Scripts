#!/usr/bin/env bash

python -c "import urllib, sys; print urllib.quote(sys.argv[1])" "$1"
