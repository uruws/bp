ARG APP
ARG APP_TAG

FROM uws/${APP}:${APP_TAG}

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="220412"

USER root:root
WORKDIR /root

ENV USER root
ENV HOME /root

USER uws:uws
WORKDIR /home/uws

ENV USER uws
ENV HOME /home/uws

ARG APP_NAME
WORKDIR ${HOME}/${APP_NAME}

RUN meteor npm install
