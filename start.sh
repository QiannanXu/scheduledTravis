#!/bin/bash
set -e

function updateFile {
  rake start
}

REPO=`git config remote.origin.url`
SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
SHA=`git rev-parse --verify HEAD`
TARGET_BRANCH=scheduled

git config user.name "Travis-CI"
git config user.email "$COMMIT_AUTHOR_EMAIL"
git checkout -b $TARGET_BRANCH

updateFile

if [[ `git status --porcelain` ]]; then
  updateFile
fi

git add -A
git commit -m "Daily cronjob update ${SHA}"

# Get the deploy key by using Travis's stored variables to decrypt deploy_key.enc
openssl aes-256-cbc -K $encrypted_f996a0be0572_key -iv $encrypted_f996a0be0572_iv -in deploy_key.enc -out deploy_key -d
chmod 600 deploy_key
eval `ssh-agent -s`
ssh-add deploy_key

# Now that we're all set up, we can push.
git push $SSH_REPO $TARGET_BRANCH
