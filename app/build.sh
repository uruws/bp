#!/bin/sh
set -eu
app_tag=$(git -C app/src describe --tags | cut -d/ -f2)
exec docker build --rm -t uws/app:${app_tag} ./app
