#!/bin/sh
set -eu
version=${1:?'clean version?'}
docker images | grep -F ${version} | awk '{ print $1":"$2 }' | xargs docker rmi
docker system prune -f
exit 0
