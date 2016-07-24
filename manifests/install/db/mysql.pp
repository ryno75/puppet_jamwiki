# == Class jamwiki::install::db::mysql
#
# This class is called from jamwiki::install::db
# and installs the mysql connector
#
class jamwiki::install::db inherits jamwiki::install::db {

  $connector = basename($connector_url)
  $connector_path = "$classpath/$connector"

  exec { 'download_connector':
    command => "wget -O ${connector_path} ${connector_url}",
    path    => ['/bin', '/usr/bin'],
    creates => $connector_path,
  }
 
}

