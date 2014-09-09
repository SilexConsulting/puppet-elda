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

  $elda_source = "${elda::params::download_url}${elda::params::elda_package_name}"

  # Download and install the Elda API front end WAR file into the tomcat webapps directory
  exec { 'elda-download':
    path      => ['/usr/bin', '/usr/sbin', '/bin'],
    command   => "wget ${elda_source}",
    cwd       => $elda::params::tomcat_webapps_path,
    creates   => "${elda::params::tomcat_webapps_path}/${elda::params::elda_package_name}",
    timeout   => 0,
  }
}
