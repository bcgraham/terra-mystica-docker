#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
groupadd -r postgres && useradd -r -g postgres postgres
apt-get -yqq update 
apt-get install $minimal_apt_get_args $BUILD_PACKAGES

#perl dependencies
curl -L http://cpanmin.us | perl - App::cpanminus 
cpanm -q $PERL_PACKAGES

# apache, pcre, fast_cgi 
mkdir /root/build
cd /root/build
wget -q ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.37.tar.bz2 && tar jxf pcre-8.37.tar.bz2 && rm -f pcre-8.37.tar.bz2 
curl --silent http://fossies.org/linux/www/apache_httpd_modules/mod_fastcgi-2.4.6.tar.bz2 | tar jx 
curl --silent http://apache.cs.utah.edu//httpd/httpd-2.2.31.tar.bz2 | tar jx
cd /root/build/pcre-8.37
./configure -q && make -s && make -s install 
cd /root/build/httpd-2.2.31
./configure -q --with-prefix=/usr/local/apache2 --enable-headers --enable-rewrite --enable-proxy && make -s && make -s install 
cd /root/build/mod_fastcgi-2.4.6
cp Makefile.AP2 Makefile && make -s && make -s install 

# game source 
git clone -q https://github.com/bcgraham/terra-mystica.git /terra-mystica 
mkdir /terra-mystica/logs /terra-mystica/www-docker /terra-mystica/www-docker/logs /terra-mystica/www-docker/conf
cp /usr/local/apache2/conf/mime.types /terra-mystica/www-docker/conf/mime.types
cd /terra-mystica
emacs --batch --load org --file=usage.org --eval '(setq org-html-postamble nil)' --funcall org-html-export-to-html
perl /terra-mystica/deploy.pl www-docker
perl -e "printf qq(insert into secret (secret, shared_iv) values ('%x%x'::bytea, '%x'::bytea);), map { rand 2**32 } 0..2" >> /permissions_and_seed.sql 

