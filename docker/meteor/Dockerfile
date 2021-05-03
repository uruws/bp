FROM uws/app:base

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="2021.05.03"

RUN curl -sS https://install.meteor.com/?release=1.10.2 | /bin/sh

ENV PATH /home/uws/.meteor:${PATH}

RUN meteor --version

RUN export METEOR_NODE=$(meteor node -e "process.stdout.write(process.execPath)"); \
	export METEOR_NPM=$(dirname ${METEOR_NODE})/npm; \
	mkdir -vp /home/uws/bin \
	&& install -v -m 0755 ${METEOR_NODE} /home/uws/bin/node \
	&& ln -sv ${METEOR_NPM} /home/uws/bin/npm

ENV PATH /home/uws/bin:${PATH}

RUN node --version
RUN npm --version
