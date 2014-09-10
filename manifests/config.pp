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
class elda::config {

  $source_parts = split($elda::elda_source, '/')

  # Download the Elda API front end WAR file into the tomcat webapps directory
  exec { 'elda-download':
    path      => ['/usr/bin', '/usr/sbin', '/bin'],
    command   => "wget ${elda::elda_source}",
    cwd       => $elda::params::tomcat_webapps_path,
    creates   => "${elda::params::tomcat_webapps_path}/${source_parts[-1]}",
    timeout   => 0,
  }
}
