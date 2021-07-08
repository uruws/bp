FROM uws/buildpack:base

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="20210708"

RUN curl -sS https://install.meteor.com/?release=1.10.2 | /bin/sh

RUN mkdir -vp /home/uws/bin \
	&& ln -sv /home/uws/.meteor/meteor /home/uws/bin/meteor

ENV PATH /home/uws/bin:${PATH}

RUN export METEOR_NODE=$(meteor node -e "process.stdout.write(process.execPath)"); \
	export METEOR_NPM=$(dirname ${METEOR_NODE})/npm; \
	ln -sv ${METEOR_NODE} /home/uws/bin/node \
	&& ln -sv ${METEOR_NPM} /home/uws/bin/npm

RUN echo "*** $(meteor --version)" \
	&& echo "***   Node $(node --version)" \
	&& echo "***    NPM $(npm --version)"
