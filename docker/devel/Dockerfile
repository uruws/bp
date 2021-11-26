FROM uws/python-2109

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="211126"

USER root:root
WORKDIR /root

ENV USER root
ENV HOME /root

RUN /root/bin/apt-install.sh shellcheck

RUN install -v -d -m 0750 -o uws -g uws /srv/deploy/Buildpack

USER uws:uws
WORKDIR /home/uws

ENV USER uws
ENV HOME /home/uws

WORKDIR /srv/deploy/Buildpack
