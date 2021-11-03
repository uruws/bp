FROM uws/meteor:1.10.2-2109

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="210927"

ARG APP
ENV APP ${APP}

RUN install -v -d -m 0750 ${HOME}/${APP}/

COPY --chown=uws:uws ./src/ ${HOME}/${APP}/
