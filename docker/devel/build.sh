#!/bin/sh
set -eu
exec docker build $@ --rm -t uws/buildpack:devel ./docker/devel
