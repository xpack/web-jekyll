#! /bin/bash

cd "$(dirname "$0")"

site="../web-html/docs"

rm -rf "${site}"
mkdir -p "${site}"

export PATH="$HOME/opt/homebrew/jekyll/bin":$PATH
bundle exec jekyll build --destination "${site}" --baseurl ""

export NOKOGIRI_USE_SYSTEM_LIBRARIES=true

# Validate images and links (internal & external).
# https://github.com/gjtorikian/html-proofer
bundle exec htmlproofer \
  --allow_hash_href \
  --http-status-ignore="429" \
  "${site}" \
  || true

echo
echo "Done"
