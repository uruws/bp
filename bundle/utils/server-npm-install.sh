#!/bin/sh
set -eu
app=${1:?'app name?'}
cd /opt/${app}/bundle/programs/server
exec meteor npm install --production
