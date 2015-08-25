#!/bin/bash 
su -c "perl -I/terra-mystica/src /terra-mystica/src/genratings.pl > /terra-mystica/www-docker/data/ratings.json" daemon
su -c "perl -I/terra-mystica/src /terra-mystica/src/genstats.pl > /terra-mystica/www-docker/data/stats.json" daemon
