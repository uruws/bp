.PHONY: default
default: all

.PHONY: all
all: docker/base docker/meteor app/src app install bundle deploy

.PHONY: docker/base
docker/base:
	@./docker/base/build.sh

.PHONY: docker/meteor
docker/meteor:
	@./docker/meteor/build.sh

.PHONY: app/src
app/src:
	@git submodule update --init app/src

.PHONY: app
app:
	@./app/build.sh

.PHONY: install
install:
	@./install/build.sh

.PHONY: bundle
bundle:
	@./bundle/build.sh

.PHONY: deploy
deploy:
	@./deploy/build.sh
