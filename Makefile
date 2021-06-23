APP_SRC ?= src
BUILD_TAG != git describe --always
APP_BUILD_TAG != git -C app/$(APP_SRC) describe --tags | cut -d/ -f2

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

.PHONY: publish-app
publish-app:
	@/srv/uws/deploy/host/ecr-login.sh us-east-2
	@/srv/uws/deploy/cluster/ecr-push.sh us-east-2 uws/app:deploy-$(APP_BUILD_TAG) uws:meteor-app-$(APP_BUILD_TAG)-$(BUILD_TAG)

.PHONY: beta
beta: app/beta
	@$(MAKE) app APP_SRC=beta
