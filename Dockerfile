FROM postgres:latest 
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -qq update && apt-get install -yqq \
	bzip2 \
	curl \
	g++ \
	gcc \
	git \
	libpq-dev \
	make \
	perl \
	wget 
RUN curl -L --silent http://cpanmin.us | perl - App::cpanminus && cpanm -q install \
	File::Slurp \
	Moose \
	JSON \
	Method::Signatures::Simple \
	Exporter::Easy \
	DBI \
	Bytes::Random::Secure \
	Digest::SHA1 \
	Crypt::Eksblowfish::Bcrypt \
	Crypt::CBC \
	indirect \
	Readonly \
	Clone \
	Math::Random::MT \
	Data::Password::Common \
	Statistics::Descriptive \
	CGI::PSGI \
	Text::Diff \
	Task::Plack \
	DBD::Pg \
	Crypt::Blowfish

WORKDIR /root
RUN wget -q ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.37.tar.bz2 && tar jxf pcre-8.37.tar.bz2 && rm -f pcre-8.37.tar.bz2 && curl --silent http://fossies.org/linux/www/apache_httpd_modules/mod_fastcgi-2.4.6.tar.bz2 | tar jx && curl --silent http://apache.cs.utah.edu//httpd/httpd-2.2.31.tar.bz2 | tar jx
WORKDIR /root/pcre-8.37
RUN ./configure -q && make -s && make -s install 
WORKDIR /root/httpd-2.2.31
RUN ./configure -q --with-prefix=/usr/local/apache2 --enable-headers --enable-rewrite --enable-proxy && make -s && make -s install 
WORKDIR /root/mod_fastcgi-2.4.6
RUN cp Makefile.AP2 Makefile && make -s && make -s install 

RUN apt-get remove -yqq \
	bzip2 \
	curl \
	g++ \
	gcc \
	make \
	wget 

RUN git clone https://github.com/bcgraham/terra-mystica.git /terra-mystica 
RUN mkdir /terra-mystica/logs /terra-mystica/www-docker /terra-mystica/www-docker/logs /terra-mystica/www-docker/conf
RUN cp /usr/local/apache2/conf/mime.types /terra-mystica/www-docker/conf/mime.types
WORKDIR /terra-mystica
RUN perl /terra-mystica/deploy.pl www-docker
COPY dbsetup.sh /docker-entrypoint-initdb.d/
COPY initialize.sh /
RUN chmod 777 /initialize.sh
ENTRYPOINT /initialize.sh
EXPOSE 80