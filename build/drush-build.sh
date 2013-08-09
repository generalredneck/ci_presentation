# pass all arguments to drush
while [ $# -gt 0 ]; do
  drush_flags="$drush_flags $1" 
  shift
done

drush="drush $drush_flags" 

# can't run this on a dir shared via nfs, so non-starter for vagrant
# sudo $(dirname "$0")/file-permissions.sh --drupal_user=$USER --drupal_path=$PWD --httpd_group=www-data;

build_path=$(dirname "$0")
$drush si -y --account-pass='adm1n' 
#$drush sqlc < $build_path/ref_db/*.sql -y &&
#rm -rf /var/drupals/gc011/www/sites/default/files &&
#tar -zxvf $build_path/ref_db/_gc011_files.tar.gz_ -C /var/drupals/gc011/www/sites/default/ &&
$drush en $(cat $build_path/mods_enabled | tr '\n' ' ') -y &&
$drush cc all &&
$drush fra -y &&
$drush dis comment shortcut overlay toolbar -y &&
$drush cc all -y
