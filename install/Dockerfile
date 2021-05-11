ARG APP_TAG

FROM uws/app:${APP_TAG}

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="20210511"

WORKDIR ${HOME}/app

RUN meteor npm install
