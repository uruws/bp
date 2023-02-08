FROM uws/meteor:devel

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="230208"

ARG APP
ENV APP ${APP}

RUN install -v -d -m 0750 ${HOME}/${APP}/

COPY --chown=uws:uws ./check/star/ ${HOME}/${APP}/

COPY --chown=uws:uws ./check/test.sh ${HOME}/${APP}/test.sh
RUN chmod -v 0750 ${HOME}/${APP}/test.sh
