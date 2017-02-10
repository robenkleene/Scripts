#!/bin/bash

sed 's/^/			/' | sed 's/^			Test Suite/Test Suite/' | sed 's/^			Test Case/	Test Case/' | sed 's/^				 Executed/Executed/'
