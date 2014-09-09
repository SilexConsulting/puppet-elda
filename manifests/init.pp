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
class elda inherits elda::params {
  class {'elda::install': } ->
  class {'elda::config': } ~>
  Service['tomcat7'] ->
  Class['elda']
}
