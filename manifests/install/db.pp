# == Class jamwiki::install::db
#
# This class is called from jamwiki::install.
#
class jamwiki::install::db (
  $classpath     = $jamwiki::params::classpath,
  $connector_url = $jamwiki::params::connector_url,
  $db_type       = $jamwiki::params::db_type,
) inherits jamwiki {

  case $db_type {
    'mysql':    { include jamwiki::install::db::mysql }
    'postgres': { include jamwiki::install::db::postgres }
  }

}
