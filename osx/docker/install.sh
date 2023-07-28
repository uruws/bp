#!/bin/sh
# https://docs.docker.com/desktop/install/mac-install/
set -xeu

sudo softwareupdate --install-rosetta

brew update
brew upgrade

brew install docker

rm -vf /var/tmp/Docker.dmg
curl -o /var/tmp/Docker.dmg https://desktop.docker.com/mac/main/arm64/Docker.dmg

sudo hdiutil attach /var/tmp/Docker.dmg
sudo /Volumes/Docker/Docker.app/Contents/MacOS/install --user="${USER}"
sudo hdiutil detach /Volumes/Docker

exit 0
