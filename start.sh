#!/bin/bash
set -e

basedir=$(dirname $0)
echo "baseDir: ${basedir}"

if [ -n "$GITHUB_API_KEY" ]; then
    git init
    git -c user.name='travis' -c user.email='travis' pull https://QiannanXu:$GITHUB_API_KEY@github.com/QiannanXu/scheduledTravis master

    ruby init.rb

    git add -A
    git status
    git -c user.name='travis' -c user.email='travis' commit -m 'hourly cronjob backup `date`'
    git push https://QiannanXu:$GITHUB_API_KEY@github.com/QiannanXu/scheduledTravis master
fi
