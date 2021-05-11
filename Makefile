APP_SRC ?= src

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
	@APP_SRC=$(APP_SRC) ./install/build.sh

.PHONY: bundle
bundle: install
	@APP_SRC=$(APP_SRC) ./bundle/build.sh

.PHONY: deploy
deploy: bundle
	@APP_SRC=$(APP_SRC) ./deploy/build.sh

.PHONY: app/src
app/src:
	@git submodule update --init app/src

.PHONY: app
app: app/src
	@APP_SRC=$(APP_SRC) ./app/build.sh
	@$(MAKE) deploy APP_SRC=$(APP_SRC)

.PHONY: app/beta
app/beta:
	@git submodule update --init app/beta

.PHONY: beta
beta: app/beta
	@$(MAKE) app APP_SRC=beta
