# Class: elda::params
#
# This module manages elda parameters which are inherited by the install class.
#
class elda::params {
  require tomcat

  $tomcat_service               = $tomcat::service_name
  $tomcat_package               = $tomcat::package_name

  $elda_source                  = 'https://s3-eu-west-1.amazonaws.com/organograms/RELEASE-0.1/organogram.war'

  case $::osfamily {
    'Debian': {
      $tomcat_webapps_path  = "/var/lib/${tomcat_package}/webapps"
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
