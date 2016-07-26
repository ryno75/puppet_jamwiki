# Class: jamwiki
# ===========================
#
# Installs and configure Jamwiki on top of a Java EE server
#
# Parameters
# ----------
#
# * `classpath`
#   Specify the J2EE claspath (for loading the DB connector jar)
#   type: absolute_path
#	default: undef (results in internal DB)
#
# * `config_hash`
#   A key/value hash containg jamwiki.properties config keys and values
#   type: hash
#	default: undef
#
# * `db_connector_url`
#   http/https URL to download conncetor jar file from
#   type: string
#	default: a mysql connector
#
# * `db_name`
#   Backend database name
#   type: string
#	default: undef (results in internal DB)
#
# * `db_port`
#   Backend database TCP port
#   type: integer
#	default: undef (results in internal DB)
#
# * `db_type`
#   type: string
#   Backend database type (currently only mysql and postgres supported)
#	default: undef (results in internal DB)
#
# * `filesys_dir`
#   The local path on the server to use for jamwiki file system path
#   type: absolute_path
#	default: /usr/local/share/jamwiki
#
# * `group`
#   The group to associate service and file ownership with (e.g. tomcat)
#   type: string
#	default: tomcat
#
# * `install_path`
#   The path where the war file will be installed
#   type: absolute_path
#	default: undef
#
# * `jamwiki_vesion`
#   The version of jamwiki which you are installing (should match version in war_url)
#   type: string
#	default: 1.3.2
#
# * `logo_url`
#   An image file url to the desired logo image
#   type: string
#	default: undef
#
# * `root_symlink`
#   If true will create a ROOT symlink in install_path
#   type: boolean
#	default: true
#
# * `service_name`
#   The name of the J2EE servie to install jamwiki under
#   type: string
#	default: undef
#
# * `user`
#   The user to associate service and file ownership with
#   type: string
#	default: tomcat
#
# * `war_url`
#   Specify the URL to download the jamwiki war file from
#   type: string
#	default: 'http://downloads.sourceforge.net/project/jamwiki/jamwiki/1.3.x/jamwiki-1.3.2.war'
#
class jamwiki (
  $classpath        = $jamwiki::params::classpath,
  $config_hash      = hiera_hash('jamwiki::config_hash',
                                 $jamwiki::params::connector_url),
  $db_connector_url = $jamwiki::params::connector_url,
  $db_hostname      = $jamwiki::params::db_hostname,
  $db_name          = $jamwiki::params::db_name,
  $db_port          = $jamwiki::params::db_port,
  $db_type          = $jamwiki::params::db_type,
  $filesys_dir      = $jamwiki::params::filesys_dir,
  $group            = $jamwiki::params::group,
  $install_path     = $jamwiki::params::install_path,
  $logo_url         = $jamwiki::params::logo_url,
  $root_symlink     = $jamwiki::params::root_symlink,
  $server_name      = $jamwiki::params::server_name,
  $service_name     = $jamwiki::params::service_name,
  $user             = $jamwiki::params::user,
  $war_url          = $jamwiki::params::war_url
) inherits jamwiki::params {

  # validate parameters here
  validate_absolute_path($filesys_dir)
  validate_string($group)
  validate_absolute_path($install_path)
  validate_bool($root_symlink)
  validate_string($server_name)
  validate_string($service_name)
  validate_string($user)
  validate_string($war_url)

  if $classpath {
    validate_absolute_path($classpath)
  }
  if $config_hash {
    validate_hash($config_hash)
  }
  if $db_connector_url {
    validate_string($db_connector_url)
  }
  if $db_hostname {
    validate_string($db_hostname)
  }
  if $db_name {
    validate_string($db_name)
  }
  if $db_port {
    validate_integer($db_port)
  }
  if $db_type {
    validate_string($db_type)
  }
  if $logo_url {
    validate_string($logo_url)
  }

  # set file defaults
  File {
    group => $group,
    owner => $user,
  }

  class { 'jamwiki::install': } ->
  class { 'jamwiki::config': } ->
  Class['jamwiki']
}

