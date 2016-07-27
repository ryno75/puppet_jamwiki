# == Class jamwiki::install::db
#
# This class is called from jamwiki::install.
#
class jamwiki::install::db inherits jamwiki {

  if $db_type {
    $connector = basename($db_connector_url)
    $connector_path = "$classpath/$connector"

    exec { 'download_connector':
      command => "wget -O ${connector_path} ${db_connector_url}",
      path    => ['/bin', '/usr/bin'],
      creates => $connector_path,
    }
}
  case $db_type {
    'mysql':    { include jamwiki::install::db::mysql }
    'postgres': { include jamwiki::install::db::postgres }
  }

}
