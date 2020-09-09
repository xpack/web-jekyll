#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Safety settings (see https://gist.github.com/ilg-ul/383869cbb01f61a51c4d).

if [[ ! -z ${DEBUG} ]]
then
  set ${DEBUG} # Activate the expand mode if DEBUG is anything but empty.
else
  DEBUG=""
fi

set -o errexit # Exit if command failed.
set -o pipefail # Exit if pipe failed.
set -o nounset # Exit if variable not set.

# Remove the initial space and instead use '\n'.
IFS=$'\n\t'

# -----------------------------------------------------------------------------

# https://docs.travis-ci.com/user/environment-variables/#Default-Environment-Variables

# -----------------------------------------------------------------------------

slug="${TRAVIS_BUILD_DIR}"
dest_folder="${HOME}/out/${GITHUB_DEST_REPO}"
site_folder="${dest_folder}/docs"

if [ "${TRAVIS_BRANCH}" == "master" ]
then
  baseurl=""
  github_dest_repo="${GITHUB_DEST_REPO}"
else
  baseurl="/web-preview"
  github_dest_repo="${GITHUB_PREVIEW_REPO}"
fi

# Temporarily disable it if needed. Anyway htmlproofer failures are ignored.
do_htmlproof="y"

# -----------------------------------------------------------------------------

function run_verbose()
{
  echo "[$@]"
  "$@"
}

# -----------------------------------------------------------------------------

# Not available:
#   tree

# Errors in this function will break the build.
function do_before_install() {

  echo "Before install, bring extra tools..."

  cd "${HOME}"

  # Not needed, already available.
  # run_verbose gem install bundler
  # run_verbose bundler --version

  run_verbose gem install html-proofer
  run_verbose htmlproofer --version

  # run_verbose gem update --system

  echo "env..."
  env | sort

  return 0
}

# Errors in this function will break the build.
function do_before_script() {

  echo "Before starting the job, clone the destination repo..."

  cd "${HOME}"

  run_verbose git config --global user.email "${GIT_COMMIT_USER_EMAIL}"
  run_verbose git config --global user.name "${GIT_COMMIT_USER_NAME}"

  # Clone the destination repo.
  run_verbose git clone --branch=master https://github.com/${github_dest_repo}.git "${dest_folder}"

  return 0
}

# Errors in this function will break the build.
function do_script() {

  echo "The main job code; perform the Jekyll build and deploy..."

  cd "${slug}"

  # Be sure the 'vendor/' folder is excluded
  # otherwise a strage error occurs.
  run_verbose bundle exec jekyll build --destination "${site_folder}" --baseurl "${baseurl}"

  # Explicitly tell GitHub not to run its own Jekyll code.
  touch "${site_folder}/.nojekyll"

  # Temporary test the Apple URL, to help diagnose htmlproofer.
  # curl -L --url http://developer.apple.com/xcode/downloads/ --verbose

  if [ "${do_htmlproof}" == "y" ]
  then
    # Mainly to validate the internal & external links.
    # https://github.com/gjtorikian/html-proofer
    # run_verbose bundle exec htmlproofer --only-4xx "${site_folder}"
    # run_verbose bundle exec htmlproofer --url-ignore "/img.shields.io/,/uk.farnell.com/,/blogs.msdn.com/,/sourceforge.net/,/bintray.com/,/www.amazon.com/,/gnuarmeclipse.livius.net/,/www.oracle.com/,/my.st.com/,/community.st.com/,/stm32duino.com/,/reference.digilentinc.com/" "${site_folder}"
    # External links are not stable, to disable checks use --disable_external

    run_verbose rm -rf ~/tmp/site
    run_verbose mkdir -p ~/tmp/site${baseurl}
    run_verbose cp -rf "${site_folder}"/* ~/tmp/site${baseurl}

    run_verbose bundle exec htmlproofer \
      --allow_hash_href \
      --disable_external \
      ~/tmp/site || true
  fi

  # ---------------------------------------------------------------------------
  # The deployment code is present here (and not in after_success),
  # to break the build if not successful.

  cd "${dest_folder}"
  
  if [ "${TRAVIS_PULL_REQUEST}" != "false" ]
  then
    echo "A pull request, skip deploy."
    return 0;
  fi

  is_dirty=`git status --porcelain`
  # Should detect new, modified, removed files.
  if [ -z "${is_dirty}" ]
  then
    echo "No changes to the output on this push; skip deploy."
    exit 0
  fi

  # run_verbose git diff

  run_verbose git add --all .
  run_verbose git commit -m "Travis CI Deploy of ${TRAVIS_COMMIT_MESSAGE} ${TRAVIS_COMMIT}"

  # git status

  echo "Deploy to GitHub pages..."

  # Must be quiet and have no output, to not reveal the key.
  echo git push --force --quiet "https://${GITHUB_TOKEN}@github.com/${github_dest_repo}" master
  git push --force --quiet "https://${GITHUB_TOKEN}@github.com/${github_dest_repo}" master > /dev/null 2>&1

  return 0
}

# Errors in the following function will not break the build.

function do_after_success() {

  echo "Nothing to do after success..."
  return 0
}

function do_after_failure() {

  echo "Nothing to do after failure..."
  return 0
}

function do_deploy() {

  echo "Nothing to do to deploy..."
  return 0
}

function do_after_script() {

  echo "Nothing to do after script..."
  return 0
}

# -----------------------------------------------------------------------------

if [ $# -ge 1 ]
then
  action=$1
  shift

  case ${action} in

  before_install)
    do_before_install "$@"
    ;;

  before_script)
    do_before_script "$@"
    ;;

  script)
    do_script "$@"
    ;;

  after_success)
    do_after_success "$@"
    ;;

  after_failure)
    do_after_failure "$@"
    ;;

  deploy)
    do_deploy "$@"
    ;;

  after_script)
    do_after_script "$@"
    ;;

  *)
    echo "Unsupported command" "${action}" "$@"
    exit 1
    ;;
   
  esac
  exit 0
else
  echo "Missing command"
  exit 1
fi

# -----------------------------------------------------------------------------
