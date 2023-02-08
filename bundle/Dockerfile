ARG APP
ARG APP_TAG

FROM uws/${APP}:install-${APP_TAG}

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="230208"

ARG APP_NAME
ENV APP ${APP_NAME}

USER root:root
WORKDIR /root

ENV USER root
ENV HOME /root

RUN install -v -d -m 0750 -o uws -g uws /opt/${APP}

USER uws:uws
WORKDIR /home/uws

ENV USER uws
ENV HOME /home/uws

RUN touch /var/tmp/fake-openssl.cnf
ENV OPENSSL_CONF /var/tmp/fake-openssl.cnf

COPY --chown=uws:uws ./utils/*.sh /home/uws/utils/

RUN /home/uws/utils/meteor-build.sh ${APP}

RUN /home/uws/utils/server-npm-install.sh ${APP}
