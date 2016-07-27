# == Class jamwiki::params
#
# This class is meant to be called from jamwiki.
# It sets same default paramaters.
#
class jamwiki::params {
  case $osfamily {
    'Debian': {
    }
    'RedHat', 'Amazon': {
    }
    default: {
      fail("${operatingsystem} not supported")
    }
  }
  $classpath        = undef
  $config_hash      = undef
  $db_connector_url = 'https://s3-us-west-2.amazonaws.com/puppet-depot/src/mysql-connector-java-5.1.39-bin.jar'
  $db_hostname      = undef
  $db_name          = undef
  $db_port          = undef
  $db_type          = undef
  $filesys_dir      = '/usr/local/share/jamwiki'
  $group            = 'tomcat'
  $install_path     = undef
  $jamwiki_version  = '1.3.2'
  $logo_url         = undef
  $properties_file  = undef
  $root_symlink     = true
  $server_name      = $fqdn
  $service_name     = 'tomcat'
  $user             = 'tomcat'
  $war_url          = 'http://downloads.sourceforge.net/project/jamwiki/jamwiki/1.3.x/jamwiki-1.3.2.war'
}
