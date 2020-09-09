#! /bin/bash

cd "$(dirname "$0")"

base_folder_path="../web-preview.git"
site_folder_path="${base_folder_path}/docs"
tmp_folder_path="${base_folder_path}/tmp"

export PATH="$HOME/opt/homebrew/jekyll/bin":$PATH

rm -rf "${tmp_folder_path}"
mkdir -pv "${tmp_folder_path}"

bundle exec jekyll build --destination "${tmp_folder_path}/web-preview" --baseurl "/web-preview"

export NOKOGIRI_USE_SYSTEM_LIBRARIES=true

# Validate images and links (internal & external).
# https://github.com/gjtorikian/html-proofer

# --disable_external
bundle exec htmlproofer \
  --allow-hash-href \
  --http-status-ignore="429" \
  "${tmp_folder_path}" \
  || true

rm -rf "${site_folder_path}"
mkdir -pv "${site_folder_path}"
mv "${tmp_folder_path}/web-preview"/* "${site_folder_path}"
touch "${site_folder_path}/.nojekyll"
rm -rf "${tmp_folder_path}"

echo
echo "Done"
