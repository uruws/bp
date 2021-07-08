#!/bin/sh
set -eu
if test 'X0' = "X$(id -u)"; then
	echo "do not run as root!" >&2
	exit 1
fi
exec docker build $@ --rm -t uws/buildpack:base ./docker/base
