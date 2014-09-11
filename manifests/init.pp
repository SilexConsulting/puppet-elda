# == Class: elda
#
# This module manages elda
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class elda (
  $elda_source   = $elda::params::elda_source
) inherits elda::params {
  class {'elda::install': } ->
  class {'elda::config': } ~>
  Service[$elda::params::tomcat_service] ->
  Class['elda']
}
