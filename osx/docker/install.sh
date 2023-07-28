#!/bin/sh
# https://docs.docker.com/desktop/install/mac-install/
set -eu

sudo softwareupdate --install-rosetta

brew install update
brew install upgrade

brew install wget
brew install docker

wget -q -O /tmp/Docker.dmg https://desktop.docker.com/mac/main/arm64/Docker.dmg

sudo hdiutil attach /tmp/Docker.dmg
sudo /Volumes/Docker/Docker.app/Contents/MacOS/install
sudo hdiutil detach /Volumes/Docker

exit 0
