FROM uws/meteor:1.10.2

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="20210715"

RUN install -v -d -m 0750 ${HOME}/app/

COPY --chown=uws:uws ./src/ ${HOME}/app/
COPY --chown=uws:uws ./certs ${HOME}/app/private/

COPY --chown=uws:uws ./vendor/node_modules/ ${HOME}/app/node_modules/
COPY --chown=uws:uws ./vendor/package-lock.json ${HOME}/app/

COPY --chown=uws:uws ./meteor-test.sh /usr/local/bin/meteor-test.sh
