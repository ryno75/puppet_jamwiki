# Class: jamwiki
# ===========================
#
# Installs and configure Jamwiki on top of a Java EE server
#
# Parameters
# ----------
#
# * `admin_username`
#   Set's the default admin user username
#	default: undef
#
# * `admin_password`
#   Set's the default admin user password
#	default: undef
#
# * `db_type`
#   Specify the backend DB type
#	default: undef (results in internal DB)
#
# * `db_username`
#   Specify the backend DB username
#	default: undef
#
# * `db_password`
#   Specify the backend DB password
#	default: undef
#
# * `install_path`
#   The path where the war file will be installed
#	default: undef
#
# * `logo_url`
#   Specify the url to the desired logo image
#	default: undef
#
# * `root_symlink`
#   If true will create a ROOT symlink in install_path
#	default: true
#
# * `site_name`
#   Specify the wiki site name
#	default: undef
#
# * `war_url`
#   Specify the URL to download the jamwiki war file from
#	default: 'http://downloads.sourceforge.net/project/jamwiki/jamwiki/1.3.x/jamwiki-1.3.2.war'
#
class jamwiki (
  $admin_username = hiera('jamwiki::admin_username',
						  $jamwiki::params::admin_username),
  $admin_password = hiera('jamwiki::admin_password',
						  $jamwiki::params::admin_password),
  $db_type        = hiera('jamwiki::db_type',
						  $jamwiki::params::db_type),
  $db_username    = hiera('jamwiki::db_username',
						  $jamwiki::params::db_username),
  $db_password    = hiera('jamwiki::db_password',
						  $jamwiki::params::db_password),
  $logo_url       = hiera('jamwiki::logo_url',
						  $jamwiki::params::logo_url),
  $install_path   = hiera('jamwiki::install_path',
						  $jamwiki::params::install_path),
  $root_symlink   = hiera('jamwiki::root_symlink',
						  $jamwiki::params::root_symlink),
  $site_name      = hiera('jamwiki::site_name',
						  $jamwiki::params::site_name),
  $war_url        = hiera('jamwiki::war_url',
						  $jamwiki::params::war_url)
) inherits jamwiki::params {

  # validate parameters here
  validate_absolute_path($install_path)
  validate_string($war_url)
  validate_bool($root_symlink)
  if $admin_username {
    validate_string($admin_username)
  }
  if $admin_password {
    validate_string($admin_password)
  }
  if $db_type {
    validate_string($db_type)
  }
  if $db_username {
    validate_string($db_username)
  }
  if $db_password {
    validate_string($db_password)
  }
  if $logo_url {
    validate_string($logo_url)
  }
  if $site_name {
    validate_string($site_name)
  }

  class { 'jamwiki::install': } ->
  class { 'jamwiki::config': } ->
  Class['jamwiki']
}

