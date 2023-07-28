#!/bin/sh
set -u

brew uninstall docker
brew uninstall homebrew/cask/docker

if test -x /Applications/Docker.app/Contents/MacOS/uninstall; then
	sudo /Applications/Docker.app/Contents/MacOS/uninstall
fi

exit 0
