#!/bin/bash

/usr/local/apache2/bin/httpd -d /terra-mystica/www-docker -f ../config/apache.conf 

su postgres -c "$PGBIN/postgres -o \"-c listen_addresses=''\""