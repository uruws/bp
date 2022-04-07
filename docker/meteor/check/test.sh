#!/bin/sh
set -eu
meteor npm install
exec meteor test --once --driver-package meteortesting:mocha
