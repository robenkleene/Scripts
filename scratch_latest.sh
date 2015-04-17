#!/bin/bash

cd ~/Scratch/
ls -t $PWD/*.* | head -n1 | xargs echo -n