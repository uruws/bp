APP_SRC ?= src
BUILD_TAG != git describe --always
APP_BUILD_TAG != git -C app/$(APP_SRC) describe --tags | cut -d/ -f2

.PHONY: default
default: all

.PHONY: all
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

.PHONY: app
app:
	@APP_SRC=$(APP_SRC) ./app/build.sh
	@$(MAKE) deploy APP_SRC=$(APP_SRC)

.PHONY: publish-app
publish-app:
	@/srv/uws/deploy/host/ecr-login.sh us-east-1
	@/srv/uws/deploy/cluster/ecr-push.sh us-east-1 uws/app:deploy-$(APP_BUILD_TAG) uws:meteor-app-$(APP_BUILD_TAG)-$(BUILD_TAG)
	@/srv/uws/deploy/host/ecr-login.sh us-west-1
	@/srv/uws/deploy/cluster/ecr-push.sh us-west-1 uws/app:deploy-$(APP_BUILD_TAG) uws:meteor-app-$(APP_BUILD_TAG)-$(BUILD_TAG)

.PHONY: beta
beta:
	@$(MAKE) app APP_SRC=beta

.PHONY: publish-beta
publish-beta:
	@/srv/uws/deploy/host/ecr-login.sh us-east-2
	@/srv/uws/deploy/cluster/ecr-push.sh us-east-2 uws/app:deploy-$(APP_BUILD_TAG) uws:meteor-beta-$(APP_BUILD_TAG)-$(BUILD_TAG)
