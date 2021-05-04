FROM uws/app:bundle-meteor-1.10.2

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="2021.05.03"

FROM uws/app:base

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="2021.05.03"

USER root:root
WORKDIR /root

ENV USER root
ENV HOME /root

RUN /root/bin/apt-install.sh bzip2 libfontconfig1

RUN install -v -d -m 0750 -o uws -g uws /opt/app

COPY --from=0 /opt/app/bundle/ /opt/app/bundle/

USER uws:uws
WORKDIR /home/uws

ENV USER uws
ENV HOME /home/uws

WORKDIR /opt/app/bundle

RUN timeout -k20 -s15 10 node main.js || true

ENTRYPOINT exec node main.js
