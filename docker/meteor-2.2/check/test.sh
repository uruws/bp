#!/bin/sh
set -eu
exec meteor test --once --driver-package meteortesting:mocha
