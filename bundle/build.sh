#!/bin/sh
set -eu
exec docker build $@ --rm -t uws/app:bundle-meteor-1.10.2 ./bundle
