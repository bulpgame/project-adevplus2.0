FROM debian:stretch
LABEL maintainer="Adevplus20 Developers <dev@adevplus20.org>"
LABEL description="Dockerised Adevplus20Core, built from Travis"

RUN apt-get update && apt-get -y upgrade && apt-get clean && rm -fr /var/cache/apt/*

COPY bin/* /usr/bin/
