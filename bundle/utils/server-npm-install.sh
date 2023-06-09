#!/bin/sh
set -eux
app=${1:?'app name?'}
cd /opt/${app}/bundle/programs/server

which  meteor
meteor --version

which node
node  --version

which npm
npm   --version

which npx
npx   --version

exec npm install --production
