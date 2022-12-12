FROM uws/meteor-2211

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="221212"

ENV APP infra-ui

RUN install -v -d -m 0750 ${HOME}/${APP}/

COPY --chown=uws:uws ./src/ ${HOME}/${APP}/
