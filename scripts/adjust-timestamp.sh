#!/usr/bin/env bash

threshold=100 # seconds
git_file="$1"

author_date=$(git log -1 --format="%ai" "${git_file}")
author_timestamp=$(git log -1 --format="%at" "${git_file}")
if [ -z "${author_timestamp}" ]
then
  echo "Not commited."
  exit 1 # Not commited
fi

# dd=$(date -j -f '%Y-%m-%d %T %z' "${author_date}" +%s)

# Limit the search to the header.
last_updated=$(sed -n -e '/^---$/,/^---$/p' "${git_file}" | grep -e '^last_updated: ' | sed -e 's|last_updated: ||')
if [ -z "${last_updated}" ]
then
  echo "Has no last_updated, add it! <---------------"
  exit 2 # No last_updated
fi

last_updated_timestamp=$(date -j -f '%Y-%m-%d %T %z' "${last_updated}" +%s)

delta=$(( author_timestamp - last_updated_timestamp ))
# echo "$delta s"

function update_last() {
  echo "Updating..."
  sed -i "" -e "s|^last_updated:.*$|last_updated: $(date '+%Y-%m-%d %T %z')|" "${git_file}"
  git add "${git_file}"
}

if [ $delta -gt $threshold -o $delta -lt 0 ]
then
  echo "Age: $delta s."
  update_last
  exit 0
fi

# Questionable, since all files were committed. Probably useless.
if git diff --quiet "${git_file}"
then
  :
else
  echo "Edited."
  update_last
fi

# file_timestamp=$(date -r "${git_file}" +%s)
exit 0