#!/bin/sh
set -eu
release=${1:?'meteor release?'}
exec docker run -it --rm -u uws uws/meteor-check:${release} /home/uws/test.sh
