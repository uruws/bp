FROM uws/meteor-2309

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="230608"

USER root:root
WORKDIR /root

ENV USER root
ENV HOME /root

RUN /root/bin/apt-install.sh man-db less

USER uws:uws
WORKDIR /home/uws

ENV USER uws
ENV HOME /home/uws
