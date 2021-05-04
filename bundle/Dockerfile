FROM uws/app:install-meteor-1.10.2

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="2021.05.03"

USER root:root
WORKDIR /root

ENV USER root
ENV HOME /root

RUN /root/bin/apt-install.sh bzip2 libfontconfig1

RUN install -v -d -m 0750 -o uws -g uws /opt/app
RUN install -v -d -m 0750 -o uws -g uws /opt/app/bundle/programs/server/npm/node_modules

USER uws:uws

ENV USER uws
ENV HOME /home/uws

COPY --chown=uws:uws ./vendor/node_modules/ /opt/app/bundle/programs/server/npm/node_modules/
COPY --chown=uws:uws ./utils/*.sh /home/uws/utils/

RUN /home/uws/utils/meteor-build.sh

RUN /home/uws/utils/server-npm-install.sh
