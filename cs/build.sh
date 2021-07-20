#!/bin/sh
set -eu
app_tag=${1:?'build tag?'}
exec docker build --rm -t uws/crowdsourcing:${app_tag} ./cs
