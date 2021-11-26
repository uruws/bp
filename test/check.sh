#!/bin/sh
set -eu

echo '*** test/shellcheck.sh'
./test/shellcheck.sh

exec ./test/coverage.sh
