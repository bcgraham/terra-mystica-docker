#!/bin/bash

export PGDATA=/var/lib/postgresql/data
export PGBIN=/usr/lib/postgresql/9.4/bin
mkdir -p "$PGDATA"
chown -R postgres "$PGDATA"
chmod g+s /run/postgresql
chown -R postgres /run/postgresql
su postgres -c "$PGBIN/initdb -D $PGDATA"
su postgres -c "$PGBIN/pg_ctl start -w -o \"-c listen_addresses=''\""

su postgres -c "$PGBIN/psql -f /setup.sql"
su postgres -c "$PGBIN/psql --dbname terra-mystica -f /terra-mystica/schema/schema.sql"
su postgres -c "$PGBIN/psql --dbname terra-mystica -f /permissions_and_seed.sql"

su postgres -c "$PGBIN/pg_ctl -o \"-c listen_addresses=''\" stop"

/usr/local/apache2/bin/httpd -d /terra-mystica/www-docker -f ../config/apache.conf 

su postgres -c "$PGBIN/postgres -o \"-c listen_addresses=''\""