#!/bin/sh
set -eu
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

echo "+ npm install --no-audit"
exec npm install --no-audit
