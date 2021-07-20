FROM uws/meteor:2.2

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="20210720"

ENV APP crowdsourcing

RUN install -v -d -m 0750 ${HOME}/${APP}/

COPY --chown=uws:uws ./src/ ${HOME}/${APP}/
