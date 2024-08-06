#!/bin/sh

git_rev=`git rev-parse HEAD`

flutter build $1 --release --dart-define=GIT_REV=$git_rev
