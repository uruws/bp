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

# https://github.com/nodejs/node-gyp#on-unix
export PYTHON=/usr/bin/python3
export NODE_GYP_FORCE_PYTHON=/usr/bin/python3
export npm_config_python=/usr/bin/python3

npm install -g node-gyp

exec npm install --no-audit
