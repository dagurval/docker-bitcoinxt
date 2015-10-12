FROM ubuntu:14.04
MAINTAINER Ruben Callewaert <rubencallewaertdev@gmail.com>

VOLUME ["/bitcoin"]

ENV HOME /bitcoin
RUN useradd -s /bin/bash -m -d /bitcoin bitcoin
RUN chown bitcoin:bitcoin -R /bitcoin

ADD ./pgp.key /pgp.key

RUN cat /pgp.key | apt-key add -

RUN rm /pgp.key

RUN echo 'deb [ arch=amd64 ] http://bitcoinxt.software.s3-website-us-west-2.amazonaws.com/apt wheezy main' > /etc/apt/sources.list.d/bitcoinxt.list

RUN apt-get update && \
    apt-get install -y bitcoinxt && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

USER bitcoin

EXPOSE 8332 8333

WORKDIR /bitcoin

CMD ["btc_oneshot"]
