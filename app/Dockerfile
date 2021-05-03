FROM uws/app:meteor-1.10.2

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="2021.05.03"

RUN install -v -d -m 0750 ${HOME}/app/

COPY --chown=uws:uws ./src/ ${HOME}/app/
