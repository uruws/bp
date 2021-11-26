#!/bin/sh
set -eu
./test/shellcheck.sh
./test/coverage.sh
exit 0
