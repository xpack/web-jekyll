#! /bin/bash

cd "$(dirname "$0")"

export PATH="$HOME/.local/homebrew/jekyll/bin":$PATH

# --verbose
bundle exec jekyll serve --baseurl "" --destination _site_local --trace --draft  --port 4003

echo
echo "Done"
