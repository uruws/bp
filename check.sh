#!/bin/sh
set -eu
export BUILDPACK_TESTING=1
exec ./build.py --src . --target meteor-check --version HEAD
