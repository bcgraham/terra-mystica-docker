#!/bin/bash 
@daily root su -c "perl -I/terra-mystica/src /terra-mystica/src/genratings.pl" daemon > /terra-mystica/www-docker/data/ratings.json
@daily root su -c "perl -I/terra-mystica/src /terra-mystica/src/genstats.pl" daemon > /terra-mystica/www-docker/data/stats.json
