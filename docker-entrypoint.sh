#!/bin/bash

export PGDATA=/var/lib/postgresql/data
export PGBIN=/usr/lib/postgresql/9.4/bin
mkdir -p "$PGDATA"
chown -R postgres "$PGDATA"
chmod g+s /run/postgresql
chown -R postgres /run/postgresql
su postgres -c "$PGBIN/initdb -D $PGDATA"
su postgres -c "$PGBIN/pg_ctl -o \"-c listen_addresses=''\" start"

su postgres -c "$PGBIN/psql --dbname terra-mystica -f /sql/setup.sql"
su postgres -c "$PGBIN/psql --dbname terra-mystica -f /terra-mystica/schema/schema.sql"
su postgres -c "$PGBIN/psql --dbname terra-mystica -f /sql/permissions_and_seed.sql"

/usr/local/apache2/bin/httpd -d /terra-mystica/www-docker -f ../config/apache.conf

if [ $1 == '' ]; then
	su postgres -c "$PGBIN/pg_ctl start -o \"-c listen_addresses=''\""
else 
	su postgres -c "$PGBIN/pg_ctl start -o \"-c listen_addresses=''\""
fi 