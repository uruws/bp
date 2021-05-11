.PHONY: default
default: all

.PHONY: all
#~ all: docker/base docker/meteor app/src app install bundle deploy
all: bootstrap app beta

.PHONY: docker/base
docker/base:
	@./docker/base/build.sh

.PHONY: docker/meteor
docker/meteor:
	@./docker/meteor/build.sh

.PHONY: bootstrap
bootstrap: docker/base docker/meteor

.PHONY: install
install:
	@./install/build.sh

.PHONY: bundle
bundle: install
	@./bundle/build.sh

.PHONY: deploy
deploy: bundle
	@./deploy/build.sh

.PHONY: app/src
app/src:
	@git submodule update --init app/src

.PHONY: app
app: app/src
	@./app/build.sh

.PHONY: app/beta
app/beta:
	@git submodule update --init app/beta

.PHONY: beta
beta: app/beta
	@./beta/build.sh
