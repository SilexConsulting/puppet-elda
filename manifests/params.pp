# Class: elda::params
#
# This module manages elda parameters which are inherited by the install class.
#
class elda::params {
  $tomcat_service               = $tomcat::params::service_name
  $tomcat_package               = $tomcat::params::package_name

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
