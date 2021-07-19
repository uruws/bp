#!/bin/sh
set -eu
exec docker build $@ --rm -t uws/meteor:2.2 ./docker/meteor-2.2
