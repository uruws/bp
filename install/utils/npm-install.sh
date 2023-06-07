#!/bin/sh
set -eux
app=${1:?'app name?'}

cd "/home/uws/${app}"

MVER=$(meteor --version)
echo "Meteor: ${MVER}"

MNODE=$(meteor node -e 'process.stdout.write(process.execPath)')
MNODE_VER=$(${MNODE} --version)
echo "Node: ${MNODE_VER}"

MNPM="$(dirname "${MNODE}")/npm"
MNPM_VER=$(${MNPM} --version)
echo "NPM: ${MNPM_VER}"

exec ${MNPM} install --no-audit
