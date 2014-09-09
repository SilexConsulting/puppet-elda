# elda #

This is the elda module. It provides an Elda API front end using a Tomcat server.

Actions: DOWNLOAD & MOVE Elda war file to tomcat web apps directory using url $host:8080/organogram

Requires Tomcat server

Sample usage:
include elda
puppet apply --modulpath=/path/to -e "include elda"
