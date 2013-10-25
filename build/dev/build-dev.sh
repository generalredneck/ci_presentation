#! /usr/bin/env bash

TMP_PWD=$PWD

pushd $PWD

# Pass all arguments to drush
while [ $# -gt 0 ]; do
  drush_flags="$drush_flags $1"
  shift
done

drush="drush $drush_flags"
build_path=$(dirname "$0")

echo "Installing database.";
$drush si -y --account-pass='drupaladm1n'
echo "Enabling modules needed for local development.";
$drush en $(cat $build_path/dev_mods_enabled | tr '\n' ' ') -y -v
echo "Clearing caches.";
$drush cc all -y
echo "Enabling all caching.";
$drush vset cache 1 &&
$drush vset block_cache 1 &&
$drush vset page_compression 1

popd
