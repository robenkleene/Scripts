#!/usr/bin/env python

import os, sys, subprocess

serverurl="http://localhost:2000/"

path = os.path.realpath(sys.argv[1])
relativepath = os.path.relpath(path, os.environ['HOME'])

subprocess.call(["open", serverurl + relativepath])
