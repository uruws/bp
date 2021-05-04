FROM uws/app:install-meteor-1.10.2

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="2021.05.03"

# https://docs.meteor.com/environment-variables.html#METEOR-DISABLE-OPTIMISTIC-CACHING
ENV METEOR_DISABLE_OPTIMISTIC_CACHING 1

WORKDIR ${HOME}/app

RUN rm -rf /opt/app/bundle \
	&& meteor build /opt/app --directory --server-only

WORKDIR /opt/app/bundle/programs/server

RUN meteor npm install --production
