FROM debian:jessie 

COPY config.sh build.sh clean.sh seed.sh /build/
COPY sql/*.sql /

RUN . /build/config.sh	&& \
      /build/build.sh 	&& \
      /build/clean.sh 	&& \
      /build/seed.sh 

RUN rm -rf /build

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 80