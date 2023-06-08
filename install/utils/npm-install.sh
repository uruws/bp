#!/bin/sh
set -eux
app=${1:?'app name?'}

cd "/home/uws/${app}"

which meteor
which node
which npm
which npx

meteor --version
echo "  Node $(node --version)"
echo "   NPM $(npm --version)"
echo "   NPX $(npx --version)"

exec npm install --no-audit
