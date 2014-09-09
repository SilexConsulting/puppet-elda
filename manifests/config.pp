# Class: elda::config
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
# puppet apply --modulepath=/path/to -e "include elda"
#
class elda::config inherits elda::params {

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
