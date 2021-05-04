FROM uws/app:bundle-meteor-1.10.2

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="2021.05.03"

USER root:root
WORKDIR /root

ENV USER root
ENV HOME /root

RUN install -v -m 0755 /home/uws/app/.meteor/local/dev_bundle/bin/node /usr/local/bin/node

FROM uws/app:base

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="2021.05.03"

USER root:root
WORKDIR /root

ENV USER root
ENV HOME /root

RUN /root/bin/apt-install.sh bzip2 libfontconfig1 openssl

RUN install -v -d -m 0750 -o uws -g uws /opt/app
COPY --from=0 /opt/app/bundle/ /opt/app/bundle/

COPY --from=0 /usr/local/bin/node /usr/local/bin/node

COPY --chown=uws:uws ./meteor-start.sh /usr/local/bin/meteor-start.sh

USER uws:uws
WORKDIR /home/uws

ENV USER uws
ENV HOME /home/uws

RUN touch /tmp/fake-openssl.cnf
ENV OPENSSL_CONF /tmp/fake-openssl.cnf

WORKDIR /opt/app/bundle

RUN timeout -k20 -s15 10 node main.js || true

ENTRYPOINT exec /usr/local/bin/meteor-start.sh
