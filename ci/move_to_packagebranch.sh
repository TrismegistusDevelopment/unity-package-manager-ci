#!/bin/bash

set -e
set -x

REMOTE=$(git config --get remote.origin.url)
echo $REMOTE
COMMIT=$(git log -1 --pretty=%B)
echo $COMMIT

echo "TARGET_BRANCH is $TARGET_BRANCH"
mkdir ../$TARGET_BRANCH
git clone --branch=$TARGET_BRANCH $REMOTE ../$TARGET_BRANCH

git archive -o ../$TARGET_BRANCH/archive.tar HEAD:$FOLDER_TO_EXPORT

Ci/show_tree.sh  ../$TARGET_BRANCH

cd ../$TARGET_BRANCH

ls

echo "TEST_RUN is $TEST_RUN"

if $TEST_RUN ; then
    echo "Test build"      
    git checkout -B $TEST_BRANCH
    PUSH_BRANCH=$TEST_BRANCH
else    
    PUSH_BRANCH=$TARGET_BRANCH
fi

echo "Archive content:"
tar -tf archive.tar
tar -xf archive.tar --overwrite
rm archive.tar

git add -A

echo "Diffs:"
git diff --cached

git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"

git commit -m "$COMMIT"

git push https://$GITHUB_TOKEN@${REMOTE#*//} $PUSH_BRANCH