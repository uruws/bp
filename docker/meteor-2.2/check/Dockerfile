FROM uws/meteor:2.2

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="20210719"

ARG APP
ENV APP ${APP}

RUN install -v -d -m 0750 ${HOME}/${APP}/

COPY --chown=uws:uws ./check/star/ ${HOME}/${APP}/

COPY --chown=uws:uws ./check/test.sh ${HOME}/test.sh
RUN chmod -v 0750 ${HOME}/test.sh

WORKDIR ${HOME}/${APP}
