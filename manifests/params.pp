# Class: elda::params
#
# This module manages elda parameters which are inherited by the install class.
#
class elda::params (
  $tomcat_service = 'tomcat7',
  $elda_package_name = 'organogram.war',
  $download_url = 'https://s3-eu-west-1.amazonaws.com/organograms/RELEASE-0.1/'
) {
  case $::osfamily {
    'Debian': {
      $tomcat_webapps_path = "/var/lib/${elda::params::tomcat_service}/webapps"
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
