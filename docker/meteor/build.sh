#!/bin/sh
set -eu
exec docker build $@ --rm -t uws/app:meteor-1.10.2 ./docker/meteor
