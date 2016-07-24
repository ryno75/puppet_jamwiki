# == Class jamwiki::install::db
#
# This class is called from jamwiki::install.
#
class jamwiki::install::db inherits jamwiki {

  case $db_type {
    'mysql':    { class { 'jamwiki::install::db::mysql': } }
    'postgres': { class { 'jamwiki::install::db::postgres': } }
  }

}
