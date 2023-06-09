ARG APP
ARG APP_TAG

FROM uws/${APP}:${APP_TAG}

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="230208"

USER root:root
WORKDIR /root

ENV USER root
ENV HOME /root

USER uws:uws
WORKDIR /home/uws

ENV USER uws
ENV HOME /home/uws

COPY --chown=uws:uws ./utils/*.sh /home/uws/utils/

RUN /home/uws/utils/pre-install.sh ${APP}
RUN /home/uws/utils/npm-install.sh ${APP}
