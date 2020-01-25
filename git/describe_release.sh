#!/bin/bash
cd $1
git log --oneline $(git describe --tags --abbrev=0 @^)..@ --pretty=%B | grep -v -e "^$" | sed ':a;N;$!ba;s/\n/\\n/g'
