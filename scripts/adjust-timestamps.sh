#!/usr/bin/env bash

if git diff-index --quiet HEAD pages _posts
then
  :
else
  echo "Commit changes first."
  exit 1
fi

echo "Enumerting files..."
find pages _posts -type f -print -exec bash scripts/adjust-timestamp.sh '{}' \;

if git diff-index --quiet HEAD pages _posts
then
  :
else
  echo "Committing changes..."
  git commit -m "adjust last_updated"
fi

echo "Done."
