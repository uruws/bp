#!/bin/sh
# https://docs.docker.com/desktop/install/mac-install/
set -xeu

sudo softwareupdate --install-rosetta

rm -vf /var/tmp/Docker.dmg
curl -o /var/tmp/Docker.dmg "https://desktop.docker.com/mac/main/$(uname -m)/Docker.dmg"

sudo hdiutil attach /var/tmp/Docker.dmg
sudo /Volumes/Docker/Docker.app/Contents/MacOS/install --accept-license --user="${USER}"
sudo hdiutil detach /Volumes/Docker

exit 0
