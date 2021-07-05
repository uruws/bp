#!/bin/sh
set -eu
app_tag=${1:?'build tag?'}
exec docker run -it --rm -u uws uws/app:${app_tag} /usr/local/bin/meteor-test.sh
