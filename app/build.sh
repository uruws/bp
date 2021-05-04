#!/bin/sh
set -eu
exec docker build $@ --rm -t uws/app:source-meteor-1.10.2 ./app
