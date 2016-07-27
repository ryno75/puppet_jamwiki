# == Class jamwiki::install
#
# This class is called from jamwiki for install.
#
class jamwiki::install inherits jamwiki {

  $war_file = basename($war_url)
  $exploded_war_path = basename($war_file, '.war')
  exec { 'download_war':
    command => "wget -O ${install_path}/${war_file} ${war_url}",
    path    => ['/bin', '/usr/bin'],
    creates => "${install_path}/${war_file}",
  }
  if $root_symlink {
    file { "${install_path}/ROOT":
      ensure    => link,
      target    => $exploded_war_path,
      subscribe => Exec['download_war'],
    }
  }
  file { $filesys_dir:
    ensure => directory,
    mode   => '0775',
  }

  include jamwiki::install::db

}
