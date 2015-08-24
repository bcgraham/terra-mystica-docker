#!/bin/bash
/usr/local/apache2/bin/httpd -d /terra-mystica/www-docker -f ../config/apache.conf
/docker-entrypoint.sh postgres
