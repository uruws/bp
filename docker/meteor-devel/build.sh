#!/bin/sh
set -eu
exec docker build $@ --rm -t uws/meteor:devel ./docker/meteor-devel
