#!/bin/sh
set -xu

brew uninstall docker
brew uninstall homebrew/cask/docker

if test -x /Applications/Docker.app/Contents/MacOS/uninstall; then
	sudo /Applications/Docker.app/Contents/MacOS/uninstall && (
		sudo rm -rf /Applications/Docker.app
	)
fi

exit 0
