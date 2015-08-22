
FROM ubuntu:14.04
MAINTAINER Ruben Callewaert <rubencallewaertdev@gmail.com>

RUN cat <<EOF | apt-key add -
-----BEGIN PGP PUBLIC KEY BLOCK-----
Comment: GPGTools - https://gpgtools.org

mQINBFXPTUoBEADLYhZu9ZrtkAZog8dis59Cx+6CqAZhQBmMQPvUZ9+9NKxa7Jt4
idZT1q+2FYmbl8hhUjtkAMW0zSrTrkTBUBjsi3mak6Ormdh1L6rApaSPY+jlizON
IkoDyNf3BPEv4ccPhQi3AGXNyytgVhSIBu8kJAkrLCHMjMwA14WgM+Z7GljLCRIc
IyBIpSG0gZYs5Uq3BoZzRytspRPTsIp/+wvyX+YsxlXXOg/vzcjwiCqVVEfMVfLq
Ro8KXmnS1w2a9lBdK7M1RpftqJ3RUhbsywkyUakNdN17iUKbvGjc2OzmH+v5W/rw
DT9o0ayJ7Oa9ufsSUKq10Ylt4obVK167gXZ8yQ/nICjev7Fqc/L97D0L4fetj1K2
BNqD02iodhunK3BTDREGrUjmUL5CR5lyBlSu8GgIMeU7XyoCoJPgNa50zDCh8U+U
SK0yfNx2kGv/6UwXe9VhFDouCLhk7ca3r8ELnnUEBPxHYtV3nGBcGrfm+1Hy5wlM
Sx18LqjaP7No71TU9ZoYoKEyeoDv8ckTSfsrr5WAcDHID4vYhxIdt5tVKqxLKhn3
sOTM5rwNJ32anwZnX19HNJX7GFEe7vw7hGiyiKnckCUSh0w5WVr1wptPzS1gaMcZ
pl6IRL8ibxJ1co9lAKG3+nqF+Lkwwgvh9P75ZnPRMWQja9xnXaUJ7xWtFQARAQAB
tDlCaXRjb2luIFhUIFNpZ25pbmcgQXV0aG9yaXR5IDxzaWduaW5nQGJpdGNvaW54
dC5zb2Z0d2FyZT6JAjcEEwEKACEFAlXPTUoCGwMFCwkIBwMFFQoJCAsFFgIDAQAC
HgECF4AACgkQOZxuTpe2lWvMwhAAt+JvmZOZCL0QH9Lhk+M08Nl6TyxIf53B/dK9
mFdsUKnwoWlrJ1r46tCps10Air3IeKhNUvIPXvbuV1cQ5mVleQKOSj2Hg0TvaePU
z/sLdyjUXRCOTEY/hr96YMR7SmTRa38b+4FYY/Oz5vDaOVZrOmf7x+sGd8IUdUxX
YoFot/gliL1MR6/gaoGrL7iXsw8ZnWEWGLEx5KMOF7VLffPAsmMr7dqTpXx12xXa
wqYn6S8raOFqAteOoDdZwSjiHQEivKM90KiZb5KsyEe9iso3I2PYWUcEgnuJL5rt
z020KtGGyBwfT4NhWBC8RR5GRypTGyOkpnrpVDzArAKCL3u4t89SAh3TnC3E8mza
3RXyFcucuw20/Dxj66imUtqcORVQr5QAtColQghZKKwK2WeJ3MlmK1UnjIipGNji
imOmktl3e2P+2nHwPmRp8T3edYsIY0UnEtBtuShYQF2NGJ/Z18QzaBJ1nfdblnr9
O+2vVJENRITpDR5rfTgVEHfRR6WL39xcJuMvITZP9dvGy1MRRrFAIrR+VtAv5QEe
Z92trWqkeURZ4MnGNUnCow8rFR7dktOfOIykLSeqjCwMs8sR/qoRBaVIWXArinAj
TdTaPwul1eVlRmq/tRI5j6xbEkidkq38vWgSlOh2PjH1FVy0zGnDwdlSHN1sNk9g
cnMXk0U=
=zxQ5
-----END PGP PUBLIC KEY BLOCK-----
EOF

RUN echo 'deb [ arch=amd64 ] http://bitcoinxt.software.s3-website-us-west-2.amazonaws.com/apt wheezy main' > /etc/apt/sources.list.d/bitcoinxt.list

RUN apt-get update && \
    apt-get install -y bitcoinxt && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/bitcoin"]

ENV HOME /bitcoin
RUN useradd -s /bin/bash -m -d /bitcoin bitcoin
RUN chown bitcoin:bitcoin -R /bitcoin

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

USER bitcoin

EXPOSE 8332 8333

WORKDIR /bitcoin

CMD ["btc_oneshot"]
