FROM uws/app:source-meteor-1.10.2

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="2021.05.03"

USER root:root
WORKDIR /root

ENV USER root
ENV HOME /root

RUN /root/bin/apt-install.sh bzip2

RUN install -v -d -m 0750 -o uws -g uws /opt/app

USER uws:uws

ENV USER uws
ENV HOME /home/uws

WORKDIR ${HOME}/app

RUN meteor npm install
