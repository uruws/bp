FROM uws/app:meteor-1.10.2

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="2021.05.03"

USER root:root
WORKDIR /root

ENV USER root
ENV HOME /root

RUN /root/bin/apt-install.sh bzip2

RUN install -v -d -m 0750 -o uws -g uws /opt/app

USER uws:uws
WORKDIR /home/uws

ENV USER uws
ENV HOME /home/uws

RUN install -v -d -m 0750 ${HOME}/app/

COPY --chown=uws:uws ./src/ ${HOME}/app/

# https://docs.meteor.com/environment-variables.html#METEOR-DISABLE-OPTIMISTIC-CACHING
ENV METEOR_DISABLE_OPTIMISTIC_CACHING 1

WORKDIR ${HOME}/app

COPY --chown=uws:uws ./vendor/node_modules/ ${HOME}/app/node_modules/
COPY --chown=uws:uws ./vendor/package-lock.json ${HOME}/app/

RUN meteor npm install

RUN meteor build /opt/app --directory --server-only

WORKDIR /opt/app/bundle/programs/server

RUN meteor npm install --production

WORKDIR /opt/app/bundle

RUN timeout -k20 -s15 10 node main.js || true

ENTRYPOINT exec node main.js
