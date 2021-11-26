#!/bin/sh
set -eu
export CMD_ARGS='-it'
exec ./docker/devel/cmd.sh
