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
chsh -s /bin/bash daemon 

su -c "perl -I/terra-mystica/src /terra-mystica/src/genratings.pl" daemon > /terra-mystica/www-docker/data/ratings.json
su -c "perl -I/terra-mystica/src /terra-mystica/src/genstats.pl" daemon > /terra-mystica/www-docker/data/stats.json

cp /build/ratings_stats.sh /etc/cron.d/ratings_stats.sh
