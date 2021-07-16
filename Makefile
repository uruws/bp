BUILD_TAG != git describe --always
APP_NAME ?= NOTSET
APP_BUILD_TAG ?= NOTSET
TEST_FLAGS ?=

.PHONY: default
default: all

.PHONY: all
all: bootstrap app beta

.PHONY: docker/base
docker/base:
	@echo '***'
	@echo '*** Build: base image'
	@echo '***'
	@./docker/base/build.sh

.PHONY: docker/meteor-1.10.2
docker/meteor-1.10.2: docker/base
	@echo '***'
	@echo '*** Build: meteor 1.10.2'
	@echo '***'
	@./docker/meteor-1.10.2/build.sh

.PHONY: docker/meteor-2.2
docker/meteor-2.2: docker/base
	@echo '***'
	@echo '*** Build: meteor 2.2'
	@echo '***'
	@./docker/meteor-2.2/build.sh

.PHONY: bootstrap
bootstrap: docker/meteor-1.10.2 docker/meteor-2.2

.PHONY: install
install:
	@echo '***'
	@echo '*** NPM install: $(APP_NAME) $(APP_BUILD_TAG)'
	@echo '***'
	./install/build.sh $(APP_NAME) $(APP_BUILD_TAG)

.PHONY: bundle
bundle: install
	@echo '***'
	@echo '*** Meteor bundle: $(APP_NAME) $(APP_BUILD_TAG)'
	@echo '***'
	./bundle/build.sh $(APP_NAME) $(APP_BUILD_TAG)

.PHONY: deploy
deploy: bundle
	@echo '***'
	@echo '*** Build: $(APP_NAME) $(APP_BUILD_TAG)'
	@echo '***'
	./deploy/build.sh $(APP_NAME) $(APP_BUILD_TAG)

.PHONY: app
app: docker/meteor-1.10.2
	@echo '***'
	@echo '*** Make: $(APP_NAME) $(APP_BUILD_TAG)'
	@echo '***'
	@./app/build.sh $(APP_BUILD_TAG)
	@echo '***'
	@echo '*** Test: $(APP_NAME) $(APP_BUILD_TAG)'
	@echo '***'
	@TEST_FLAGS=$(TEST_FLAGS) ./app/test.sh $(APP_BUILD_TAG)

.PHONY: publish-app
publish-app:
	@echo '***'
	@echo '*** Publish: $(APP_NAME) $(APP_BUILD_TAG)'
	@echo '***'
	@/srv/uws/deploy/host/ecr-login.sh us-east-1
	@/srv/uws/deploy/cluster/ecr-push.sh us-east-1 uws/app:deploy-$(APP_BUILD_TAG) uws:meteor-app-$(APP_BUILD_TAG)-$(BUILD_TAG)
	@/srv/uws/deploy/host/ecr-login.sh us-west-1
	@/srv/uws/deploy/cluster/ecr-push.sh us-west-1 uws/app:deploy-$(APP_BUILD_TAG) uws:meteor-app-$(APP_BUILD_TAG)-$(BUILD_TAG)

.PHONY: beta
beta:
	@$(MAKE) app

.PHONY: publish-beta
publish-beta:
	@echo '***'
	@echo '*** Publish: $(APP_NAME) $(APP_BUILD_TAG)'
	@echo '***'
	@/srv/uws/deploy/host/ecr-login.sh us-east-2
	@/srv/uws/deploy/cluster/ecr-push.sh us-east-2 uws/app:deploy-$(APP_BUILD_TAG) uws:meteor-$(APP_BUILD_TAG)-$(BUILD_TAG)
