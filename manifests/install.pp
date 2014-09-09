# Class: elda::install
#
# This module manages elda deployment
#
# Actions: DOWNLOAD & MOVE Elda war file to tomcat web apps directory using url $host:8080/organogram
#
# Requires Tomcat server
#
# Sample usage:
#
# include elda
# puppet apply --modulpath=/path/to -e "include elda"
#
class elda::install inherits elda::params {

  #Update the package manager
  exec { 'system-update':
    path      => ['/usr/bin', '/usr/sbin', '/bin'],
    command   => "apt-get update",
  }

  #Include Tomcat module.
  include tomcat

  #Download the Elda API front end war file into the tomcat webapps directory.
  exec { "download-elda":
    command   => "curl -4sv ${::elda::params::download_url}${::elda::params::elda_package_name} > ${::elda::params::tomcat_webapps_path}/${::elda::params::elda_package_name}",
    path      => '/usr/bin',
    cwd       => $::elda::params::tomcat_webapps_path,
    onlyif    => "test ! -f ${::elda::params::tomcat_webapps_path}/${::elda::params::elda_package_name}",
    require   => Exec['system-update'],
    notify    => Service["tomcat7"],
  }


}
