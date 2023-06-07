#!/bin/sh
set -eux
app=${1:?'app name?'}

cd /home/uws/${app}

MNODE=$(meteor node -e 'process.stdout.write(process.execPath)')
${MNODE} --version

MNPM="$(dirname "${MNODE}")/npm"
${MNPM} --version

exec ${MNPM} install --no-audit
