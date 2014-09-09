# == Class elda::install
# Pre-conditions that must be met before Elda can be installed

class elda::install {
  include tomcat
  include beluga::wget
}


