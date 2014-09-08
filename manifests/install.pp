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
  file { $::elda::params::log_path:
    ensure    => directory,
    recurse   => true,
    purge     => true,
    force     => true,
    owner     => $::elda::params::owner,
    group     => $::elda::params::group,
    mode      => 766,
  }

  # Symlink the Log path under the install_path ?
  file { $::elda::params::log_symlink:
    ensure => 'link',
    force  => true,
    target => $::elda::params::log_path,
  }


  #Ensure the Install directory is created according to install_path parameter
  file { $::elda::params::install_path:
    ensure    => directory,
    recurse   => true,
    purge     => true,
    force     => true,
    owner     => $::elda::params::owner,
    group     => $::elda::params::group,
    mode      => 766,
  }

  #Download the Elda API front end archive.
  exec { "download-elda-jar":
    command   => "curl -4sv ${::elda::params::download_url}${::elda::params::elda_package_name} > ${::elda::params::install_path}/elda.jar",
    path      => '/usr/bin',
    onlyif    => "test ! -f ${::elda::params::install_path}/elda.jar",
    require   => File[$::elda::params::install_path],
  }

  #Load Jar file into tomcat webapps directory.


  exec { 'extract-elda-jar':
    path      => ['/usr/bin', '/usr/sbin', '/bin'],
    cwd       => $::elda::params::install_path,
    command   => "jar xvf ${::elda::params::install_path}/elda.jar",
    onlyif    => "test -f ${::elda::params::install_path}/elda.jar",
    require   => Exec["download-elda-jar"]
  }

  #Temp need to add to tomcat webapps instead of standalone.

  exec { 'start-jar':
    path      => ['/usr/bin', '/usr/sbin', '/bin'],
    command   => "java -jar ${::elda::params::install_path}/start.jar",
    onlyif    => "test -f ${::elda::params::install_path}/start.jar",
  }

}