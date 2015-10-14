FROM ubuntu:14.04
MAINTAINER Ruben Callewaert <rubencallewaertdev@gmail.com>

ADD ./pgp.key /pgp.key

RUN cat /pgp.key | apt-key add -

RUN rm /pgp.key

RUN echo 'deb [ arch=amd64 ] http://bitcoinxt.software.s3-website-us-west-2.amazonaws.com/apt wheezy main' > /etc/apt/sources.list.d/bitcoinxt.list

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y bitcoinxt && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

EXPOSE 8332 8333

VOLUME ["/bitcoin"]

WORKDIR /bitcoin

ENV HOME /bitcoin

ENTRYPOINT ["docker_init", "btc_oneshot"]
CMD ["-rpcallowip=::/0"]
