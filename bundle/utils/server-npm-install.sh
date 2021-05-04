#!/bin/sh
set -eu
cd /opt/app/bundle/programs/server
exec meteor npm install --production
