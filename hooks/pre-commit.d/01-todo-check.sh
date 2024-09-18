#!/bin/bash

NUM_FOUND=`git diff --cached | grep -c -E '^\+[^+].*(TODO|FIXME)'`

if [[ "$NUM_FOUND" -gt 0 ]]; then
	echo "seems you forgot solve all your TODO's and FIXME's before committing ☝️"
	echo "$NUM_FOUND found in current changes"
	exit 1
fi
