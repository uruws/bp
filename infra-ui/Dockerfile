FROM uws/meteor-2309

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="230208"

ENV APP infra-ui

RUN install -v -d -m 0750 ${HOME}/${APP}/

COPY --chown=uws:uws ./src/ ${HOME}/${APP}/
