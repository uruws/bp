#!/bin/sh
set -eu

# https://docs.meteor.com/environment-variables.html#METEOR-DISABLE-OPTIMISTIC-CACHING
export METEOR_DISABLE_OPTIMISTIC_CACHING=1

cd ${HOME}/app

exec meteor build /opt/app --directory --server-only
