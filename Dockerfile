FROM debian:jessie 
ENV DEBIAN_FRONTEND=noninteractive

COPY config.sh build.sh clean.sh /build/
COPY sql/*.sql /

RUN . /build/config.sh	&& \
      /build/build.sh 	&& \
      /build/clean.sh 	

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 80