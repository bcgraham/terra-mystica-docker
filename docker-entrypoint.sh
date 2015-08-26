#!/bin/bash

export PGDATA=/var/lib/postgresql/data
export PGBIN=/usr/lib/postgresql/9.4/bin

shutdown() { 
	service cron stop 
	kill -TERM `cat /terra-mystica/www-docker/logs/httpd.pid`
	su -c "PGDATA=$PGDATA;/usr/lib/postgresql/9.4/bin/pg_ctl stop -m smart" postgres
}

trap shutdown SIGTERM 

service cron start
/usr/local/apache2/bin/httpd -d /terra-mystica/www-docker -f /terra-mystica/config/apache.conf 
su postgres -c "$PGBIN/postgres -o \"-c listen_addresses=''\"" &

postgres_pid=$!
wait "$postgres_pid"