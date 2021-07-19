#!/bin/sh
set -eu
app=${1:?'app name?'}

# https://docs.meteor.com/environment-variables.html#METEOR-DISABLE-OPTIMISTIC-CACHING
export METEOR_DISABLE_OPTIMISTIC_CACHING=1

# https://github.com/kelaberetiv/TagUI/issues/787
export OPENSSL_CONF=/tmp/fake-openssl.cnf

cd ${HOME}/${app}

exec meteor build /opt/${app} --directory --server-only
