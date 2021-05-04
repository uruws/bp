FROM uws/app:install-meteor-1.10.2

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="2021.05.03"

USER root:root
WORKDIR /root

ENV USER root
ENV HOME /root

RUN /root/bin/apt-install.sh bzip2 libfontconfig1

RUN install -v -d -m 0750 -o uws -g uws /opt/app

USER uws:uws

ENV USER uws
ENV HOME /home/uws

# https://docs.meteor.com/environment-variables.html#METEOR-DISABLE-OPTIMISTIC-CACHING
ENV METEOR_DISABLE_OPTIMISTIC_CACHING 1

WORKDIR ${HOME}/app

RUN rm -rf /opt/app/bundle \
	&& meteor build /opt/app --directory --server-only

WORKDIR /opt/app/bundle/programs/server

RUN meteor npm install --production
