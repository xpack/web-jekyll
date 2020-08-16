#! /bin/bash

cd "$(dirname "$0")"

export PATH="$HOME/opt/homebrew/jekyll/bin":$PATH

# --verbose
bundle exec jekyll serve --baseurl "" --destination _site_local --trace --draft  --port 4002

echo
echo "Done"
