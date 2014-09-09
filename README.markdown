# E.L.D.A. Puppet module #

This module provides a front end for elda using a Tomcat server.

Actions: Downloads war file to tomcat web apps directory at this url -> $host:8080/organogram

Requires: Tomcat server

Sample usage:

include elda

puppet apply --modulepath=/path/to -e "include elda"
