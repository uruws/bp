ARG APP_TAG

FROM uws/app:install-${APP_TAG}

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="20210511"

USER root:root
WORKDIR /root

ENV USER root
ENV HOME /root

RUN /root/bin/apt-install.sh bzip2 libfontconfig1 openssl

RUN install -v -d -m 0750 -o uws -g uws /opt/app

USER uws:uws
WORKDIR /home/uws

ENV USER uws
ENV HOME /home/uws

RUN touch /tmp/fake-openssl.cnf
ENV OPENSSL_CONF /tmp/fake-openssl.cnf

COPY --chown=uws:uws ./utils/*.sh /home/uws/utils/

RUN /home/uws/utils/meteor-build.sh

RUN /home/uws/utils/server-npm-install.sh
