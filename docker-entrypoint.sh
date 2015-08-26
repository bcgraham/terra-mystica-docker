#!/bin/bash

export PGDATA=/var/lib/postgresql/data
export PGBIN=/usr/lib/postgresql/9.4/bin

service cron start
/usr/local/apache2/bin/httpd -d /terra-mystica/www-docker -f ../config/apache.conf 
su postgres -c "$PGBIN/postgres -o \"-c listen_addresses=''\""