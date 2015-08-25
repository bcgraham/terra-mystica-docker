#!/bin/bash 

export PGDATA=/var/lib/postgresql/data
export PGBIN=/usr/lib/postgresql/9.4/bin
mkdir -p "$PGDATA"
chown -R postgres "$PGDATA"
chmod g+s /run/postgresql
chown -R postgres /run/postgresql
# initialize cluster
su postgres -c "$PGBIN/initdb -D $PGDATA"
su postgres -c "$PGBIN/pg_ctl start -w -o \"-c listen_addresses=''\""

# create db and web user login 
su postgres -c "$PGBIN/psql -f /setup.sql"
# schema 
su postgres -c "$PGBIN/psql --dbname terra-mystica -f /terra-mystica/schema/schema.sql"
# grant web user permissions and seed secrets & maps 
su postgres -c "$PGBIN/psql --dbname terra-mystica -f /permissions_and_seed.sql"

su postgres -c "$PGBIN/pg_ctl stop"

# daily job for ratings & stats 
chown -R daemon /terra-mystica/www-docker/data
. /build/ratings_stats.sh 
cp /build/ratings_stats.sh /etc/cron.daily/ratings_stats.sh
