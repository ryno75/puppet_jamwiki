# == Class jamwiki::params
#
# This class is meant to be called from jamwiki.
# It sets same default paramaters.
#
class jamwiki::params {
  case $::osfamily {
    'Debian': {
    }
    'RedHat', 'Amazon': {
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
  $admin_username = undef
  $admin_password = undef
  $classpath      = undef
  $connector_url  = 'https://s3-us-west-2.amazonaws.com/puppet-depot/src/mysql-connector-java-5.1.39-bin.jar'
  $db_type        = undef
  $db_username    = undef
  $db_password    = undef
  $logo_url       = undef
  $install_path   = undef
  $root_symlink   = true
  $service_name   = undef
  $site_name      = undef
  $war_url        = 'http://downloads.sourceforge.net/project/jamwiki/jamwiki/1.3.x/jamwiki-1.3.2.war'
}
