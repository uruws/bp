#!/bin/sh
set -eux
app=${1:?'app name?'}

cd "/home/uws/${app}"

which  meteor
meteor --version

which node
node  --version

which npm
npm   --version

which npx
npx   --version

exec npm install --no-audit
