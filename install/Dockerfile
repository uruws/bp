ARG APP
ARG APP_TAG

FROM uws/${APP}:${APP_TAG}

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="20210720"

ARG APP_NAME
WORKDIR ${HOME}/${APP_NAME}

RUN meteor npm install
