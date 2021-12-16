#!/bin/bash
git add $1
git commit -m "New code"
git tag -a $2 -m "New tag"
git push origin master tag $2
