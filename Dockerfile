FROM ubuntu:14.04
MAINTAINER soluboyo@ipnxnigeria.net

RUN apt-get update
RUN apt-get -qy install git make gcc g++ libtool libpcap-dev libcurl4-gnutls-dev libsqlite3-dev libmysqlclient-dev libxml2-dev libglib2.0-dev autoconf wget libgeoip-dev groff libjson0-dev
RUN mkdir -p /root/src && cd /root/src && \
    git clone https://github.com/ntop/nDPI.git && cd nDPI && ./autogen.sh && ./configure && make
RUN cd /root/src && git clone https://github.com/ntop/ntopng.git && cd ntopng && ./autogen.sh && ./configure && make && make geoip && make install
RUN apt-get -qy install redis-server
EXPOSE 3000
CMD service redis-server start && ntopng
