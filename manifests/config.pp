# == Class jamwiki::config
#
# This class is called from jamwiki for configuration.
# At the core of this class is the config_hash param.
# The config_hash param is a key/value hash containing jamwiki parmeters and
# their values. There is no syntax checking so ensure that you provide
# the appropriate properties keys and values!
# NOTE: colons in value MUST be escaped.
#
class jamwiki::config inherits jamwiki {

  # download logo file if specified
  if $logo_url {
    $logo_file = basename($logo_url)
    $logo_path = "${filesys_dir}/${logo_url}"
    exec { 'download_logo':
      command => "wget -O ${logo_path} ${logo_url}",
      path    => ['/bin', '/usr/bin'],
      creates => $logo_path,
      require => File[$filesys_dir],
    }
  } else {
    $logo_path = 'logo_oliver.gif'
  }

  # set db related properties
  case $db_type {
    'mysql': {
      $db_handler = 'MySqlQueryHandler'
      $db_driver  = 'com.mysql.jdbc.Driver'
    }
    'postgres': {
      $db_handler = 'PostgresQueryHandler'
      $db_driver  = 'org.postgresql.Driver'
    }
    default: {
      $db_handler = 'HSqlQueryHandler'
      $db_driver  = 'org.hsqldb.jdbcDriver'
    }
  }

  if $properties_file {
    # manage custom properties file path
    $props_file_dir = dirname($properties_file)
    $props_file    = $properties_file
    exec { 'create_props_file_dir_tree':
      command => "mkdir -p -m 755 ${props_file_dir}",
      creates => $props_file_dir,
      path    => ['/bin', '/usr/bin'],
    }->
    file { $props_file_dir:
      ensure => directory,
      mode   => '0775',
    }
  } else {
    # manage stock module properties file path
    $props_file_dir = $filesys_dir
    $props_file    = "${filesys_dir}/jamwiki.properties"
  }
  file { $props_file:
    content => template("${module_name}/jamwiki.properties.erb"),
    require => File[$props_file_dir],
  }
  Ini_setting {
    ensure => present,
    path   => $props_file,
    require => File[$props_file],
  }
  # iterate over config_hash and set properties forom key/value pairs
  $config_hash.each |String $prop_name, String $prop_value| {
    ini_setting { "jamwiki.properties.${prop_name}":
      setting => $prop_name,
      value   => $prop_value,
    }
  }

}
