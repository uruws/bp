#!/bin/sh
set -eu
app_tag=${1:?'build tag?'}
exec docker build --rm -t uws/infra-ui:${app_tag} ./infra-ui
