FROM uws/buildpack:base

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="20210716"

USER root:root
WORKDIR /root

ENV USER root
ENV HOME /root

RUN /root/bin/apt-install.sh curl procps

USER uws:uws
WORKDIR /home/uws

ENV USER uws
ENV HOME /home/uws

RUN curl -sS https://install.meteor.com/?release=2.2 | /bin/sh

USER root:root
RUN chgrp -v uws /usr/local/bin \
	&& chmod -v g+w /usr/local/bin
USER uws:uws

RUN ln -sv /home/uws/.meteor/meteor /usr/local/bin/meteor

RUN export METEOR_NODE=$(meteor node -e "process.stdout.write(process.execPath)"); \
	export METEOR_NPM=$(dirname ${METEOR_NODE})/npm; \
	ln -sv ${METEOR_NODE} /usr/local/bin/node \
	&& ln -sv ${METEOR_NPM} /usr/local/bin/npm

RUN echo "*** $(meteor --version)" \
	&& echo "***   Node $(node --version)" \
	&& echo "***    NPM $(npm --version)"
