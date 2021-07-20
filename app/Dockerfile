FROM uws/meteor:1.10.2

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="20210716"

ARG APP
ENV APP ${APP}

RUN install -v -d -m 0750 ${HOME}/${APP}/

COPY --chown=uws:uws ./src/ ${HOME}/${APP}/
COPY --chown=uws:uws ./certs ${HOME}/${APP}/private/

COPY --chown=uws:uws ./vendor/node_modules/ ${HOME}/${APP}/node_modules/
COPY --chown=uws:uws ./vendor/package-lock.json ${HOME}/${APP}/
