#!/bin/sh
set -eux
app=${1:?'app name?'}

# https://docs.meteor.com/environment-variables.html#METEOR-DISABLE-OPTIMISTIC-CACHING
export METEOR_DISABLE_OPTIMISTIC_CACHING=1

# https://github.com/kelaberetiv/TagUI/issues/787
export OPENSSL_CONF=/var/tmp/fake-openssl.cnf

cd ${HOME}/${app}

# From heroku build log:
#   /tmp/codon/tmp/cache/meteor/.meteor/meteor build --platforms=web.browser --server https://dev.talkingpts.org/ --directory /tmp/codon/tmp/buildpacks/12684dcdaf0c8e69ace478395557e8d1c737cf0c/build-fObn

exec meteor build --platforms=web.browser --directory /opt/${app}
