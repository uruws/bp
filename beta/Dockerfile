FROM uws/meteor-2211

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="221212"

ARG APP
ENV APP ${APP}

RUN install -v -d -m 0750 ${HOME}/${APP}/

COPY --chown=uws:uws ./src/ ${HOME}/${APP}/
