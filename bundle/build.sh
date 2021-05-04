#!/bin/sh
set -eu
app_tag=$(git -C app/src describe --tags)
exec docker build $@ --rm -t uws/app:bundle-${app_tag} ./bundle
