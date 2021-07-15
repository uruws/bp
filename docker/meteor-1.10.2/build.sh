#!/bin/sh
set -eu
exec docker build $@ --rm -t uws/meteor:1.10.2 ./docker/meteor-1.10.2
