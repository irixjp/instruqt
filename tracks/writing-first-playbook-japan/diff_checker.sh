#!/bin/bash

# Directory path of the track from which the translation was taken
ORIG_TRACK=../writing-first-playbook

# File to be translated (not compared to original)
EXCLUDE_FILES=("diff_checker.sh" "track.yml" "assignment.md")

exclude_options=""
for file in ${EXCLUDE_FILES[@]}
do
    exclude_options+="--exclude $file "
done


echo Compare ${ORIG_TRACK} and ./
echo Exculde files: ${EXCLUDE_FILES[@]}

diff -rq ${ORIG_TRACK} ./ $exclude_options
