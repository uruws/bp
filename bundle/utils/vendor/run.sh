#!/bin/sh
set -eu
utils=/home/uws/utils
${utils}/meteor-build.sh
${utils}/server-npm-install.sh
exit 0
