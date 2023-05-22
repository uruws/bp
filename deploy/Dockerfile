ARG APP
ARG APP_TAG

FROM uws/${APP}:bundle-${APP_TAG}

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="230208"

ARG APP_NAME
ENV APP ${APP_NAME}

USER root:root
WORKDIR /root

ENV USER root
ENV HOME /root

RUN rm -vf /usr/local/bin/node
RUN install -v -m 0755 /home/uws/${APP}/.meteor/local/dev_bundle/bin/node /usr/local/bin/node

FROM uws/buildpack:base-2305

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="230208"

ARG APP_NAME2
ENV APP ${APP_NAME2}

USER root:root
WORKDIR /root

ENV USER root
ENV HOME /root

RUN install -v -d -m 0750 -o uws -g uws /opt/${APP}
COPY --from=0 /opt/${APP}/bundle/ /opt/${APP}/bundle/

COPY --from=0 /usr/local/bin/node /usr/local/bin/node

COPY --chown=uws:uws ./meteor-start.sh /usr/local/bin/meteor-start.sh

COPY --chown=uws:uws ./meteor-settings.sh /usr/local/bin/meteor-settings.sh
COPY --chown=uws:uws ./meteor-settings.js /usr/local/lib/meteor-settings.js

RUN rm -vf /usr/local/bin/meteor-test.sh

USER uws:uws
WORKDIR /home/uws

ENV USER uws
ENV HOME /home/uws

RUN touch /var/tmp/fake-openssl.cnf
ENV OPENSSL_CONF /var/tmp/fake-openssl.cnf

WORKDIR /opt/${APP}/bundle

#RUN timeout -k20 -s15 10 node main.js || true

ENTRYPOINT exec /usr/local/bin/meteor-start.sh
