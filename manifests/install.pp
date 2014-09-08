# Class: fuseki::install
#
# This module manages fuseki install configuration
#
# Parameters: SEE PARAMS.PP
#
# Actions: DOWNLOAD,EXTRACT AND MOVE Elda Standalone to install_path.
#
# Requires: TOMCAT7 JDK APACHE2
#
# Sample Usage:
#  include elda  
#  class{'elda':}
#
class elda::install(){

  include elda::params

  #Update the package manager
  exec { 'system-update':
    path      => ['/usr/bin', '/usr/sbin', '/bin'],
    command   => "apt-get update",
  }

  #Enable the java module after the packages have been updated.
  include java

  #Create the elda owner and group
  user { $::elda::params::owner:
    ensure     => "present",
    managehome => true,
  }

  #Ensure the Install directory is created according to install_path parameter
  file { $::elda::params::install_path:
    ensure    => directory,
    recurse   => true,
    purge     => false,
    force     => false,
    owner     => $::elda::params::owner,
    group     => $::elda::params::group,
    mode      => 766,
  }

  #Ensure the Log folder is created according to log_path parameter
  file { $::elda::params::log_path:
    ensure    => directory,
    recurse   => true,
    purge     => true,
    force     => true,
    owner     => $::elda::params::owner,
    group     => $::elda::params::group,
    mode      => 766,
  }

  # Symlink the log path under the install_path.
  file { $::elda::params::log_symlink:
    ensure => 'link',
    force  => true,
    target => $::elda::params::log_path,
    require => File["${::elda::params::log_path}"],
  }

  #Download the Elda API front end archive SEE STANDALONE OR CONTAINER IN params.pp .
  exec { "download-elda":
    command   => "curl -4sv ${::elda::params::download_url}${::elda::params::elda_package_name} > ${::elda::params::install_path}/${::elda::params::elda_package_name}",
    path      => '/usr/bin',
    onlyif    => "test ! -f ${::elda::params::install_path}/${::elda::params::elda_package_name}",
    require   => File[$::elda::params::install_path],
  }

  #Ensure a directory under tomcat webapps is created and filled with content.
  file {"${::elda::params::tomcat_webapps}/${::elda::params::elda_tomcat_app_name}":
    ensure    => directory,
    recurse   => true,
    purge     => false,
    force     => false,
    owner     => $::elda::params::owner,
    group     => $::elda::params::group,
    mode      => 766,
    source    => "${::elda::params::install_path}/webapps/standalone",
    require   => Exec['extract-elda'],
  }

  #Extract archive into the install directory.
  exec { 'extract-elda':
    path      => ['/usr/bin', '/usr/sbin', '/bin'],
    cwd       => "${::elda::params::install_path}",
    command   => "jar xf ${::elda::params::elda_package_name}",
    onlyif    => "test -f ${::elda::params::install_path}/${::elda::params::elda_package_name}",
    require   => Exec['download-elda'],
  }

  # Symlink the standalone webapps path under the tomcat webapps path.
    file { "${::elda::params::tomcat_webapps_path}/${::elda::params::elda_tomcat_app_name}" :
    ensure => 'link',
    force  => true,
    target => "${::elda::params::install_path}/webapps/standalone",
    require => File["${::elda::params::install_path}"],
  }

}
