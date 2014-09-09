# Class: elda::params
#
# This module manages elda parameters
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class elda::params(
  $install_path = '/usr/share/elda',
  $temp_path = '/tmp',
  $log_symlink = '/usr/share/elda/logs',
  $log_path = '/var/log/elda',
  $elda_package_name = 'organogram.war',
  $download_url = 'https://s3-eu-west-1.amazonaws.com/organograms/RELEASE-0.1/',
  $tomcat_webapps_path = "/var/lib/tomcat${tomcat::params::version}",
) {
  case $::osfamily {
      'Debian': {
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
