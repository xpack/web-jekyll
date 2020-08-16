#! /bin/bash

cd "$(dirname "$0")"

site="../xpack.github.io.html/docs"

rm -rf "${site}"
mkdir -p "${site}"

export PATH="$HOME/opt/homebrew/jekyll/bin":$PATH
bundle exec jekyll build --destination "${site}"

export NOKOGIRI_USE_SYSTEM_LIBRARIES=true

# Validate images and links (internal & external).
bundle exec htmlproofer \
  --allow_hash_href \
  --url_ignore="/www.eclipse.org/embed-cdt/,/github.com/gnu-mcu-eclipse/,/github.com/eclipse-embed-cdt/,/github.com/xpack/" \
  "${site}"

echo
echo "Done"
