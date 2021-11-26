BUILD_TAG != git describe --tags --always
APP_NAME ?= NOTSET
APP_BUILD_TAG ?= NOTSET
TEST_FLAGS ?=
LOGS_DIR ?= $(HOME)/logs
LOGF := $(LOGS_DIR)/$(APP_NAME)-build-$(APP_BUILD_TAG).log

.PHONY: default
default: bootstrap

.PHONY: bootstrap
bootstrap: docker/meteor-1.10.2 docker/meteor-2.2

.PHONY: log-init
log-init:
	@mkdir -vp $(LOGS_DIR)
	@date -R >$(LOGF)

.PHONY: clean
clean:
	@rm -rf ./build ./tmp ./__pycache__

.PHONY: prune
prune:
	@docker system prune -f

# devel image

.PHONY: devel
devel:
	@./docker/devel/build.sh

# Internal checks

.PHONY: check-meteor
check-meteor:
	@./check.sh

.PHONY: check
check:
	@./docker/devel/cmd.sh ./test/check.sh

.PHONY: meteor-check
meteor-check:
	@$(MAKE) check-devel APP_BUILD_TAG=$(APP_BUILD_TAG)
	@$(MAKE) check-1.10.2 APP_BUILD_TAG=$(APP_BUILD_TAG)
	@$(MAKE) check-2.2 APP_BUILD_TAG=$(APP_BUILD_TAG)

.PHONY: publish-meteor-check
publish-meteor-check:
	@echo 'publish-meteor-check'

# Base image

.PHONY: docker/base
docker/base:
	@echo '***'
	@echo '*** Build: base image'
	@echo '***'
	@./docker/base/build.sh

# Meteor

.PHONY: meteor
meteor: docker/meteor-devel docker/meteor-1.10.2 docker/meteor-2.2

# Meteor devel

.PHONY: docker/meteor-devel
docker/meteor-devel: docker/base
	@echo '***'
	@echo '*** Build: meteor devel'
	@echo '***'
	@./docker/meteor-devel/build.sh

.PHONY: check-devel
check-devel: docker/meteor-devel
	@echo '***'
	@echo '*** Make: meteor-check devel $(APP_BUILD_TAG)'
	@echo '***'
	@./docker/meteor-devel/check/build.sh $(APP_BUILD_TAG)
	@./test.sh meteor-check $(APP_BUILD_TAG)

# Meteor 1.10.2

.PHONY: docker/meteor-1.10.2
docker/meteor-1.10.2: docker/base
	@echo '***'
	@echo '*** Build: meteor 1.10.2'
	@echo '***'
	@./docker/meteor-1.10.2/build.sh

.PHONY: check-1.10.2
check-1.10.2: docker/meteor-1.10.2
	@echo '***'
	@echo '*** Make: meteor-check 1.10.2 $(APP_BUILD_TAG)'
	@echo '***'
	@./docker/meteor-1.10.2/check/build.sh $(APP_BUILD_TAG)
	@./test.sh meteor-check $(APP_BUILD_TAG)

# Meteor 2.2

.PHONY: docker/meteor-2.2
docker/meteor-2.2: docker/base
	@echo '***'
	@echo '*** Build: meteor 2.2'
	@echo '***'
	@./docker/meteor-2.2/build.sh

.PHONY: check-2.2
check-2.2: docker/meteor-2.2
	@echo '***'
	@echo '*** Make: meteor-check 2.2 $(APP_BUILD_TAG)'
	@echo '***'
	@./docker/meteor-2.2/check/build.sh $(APP_BUILD_TAG)
	@./test.sh meteor-check $(APP_BUILD_TAG)

# Deploy and intermediate images

.PHONY: install
install:
	@echo '***' | tee -a $(LOGF)
	@echo '*** NPM install: $(APP_NAME) $(APP_BUILD_TAG)' | tee -a $(LOGF)
	@echo '***' | tee -a $(LOGF)
	@./install/build.sh $(APP_NAME) $(APP_BUILD_TAG) | tee -a $(LOGF)

.PHONY: bundle
bundle: install
	@echo '***' | tee -a $(LOGF)
	@echo '*** Meteor bundle: $(APP_NAME) $(APP_BUILD_TAG)' | tee -a $(LOGF)
	@echo '***' | tee -a $(LOGF)
	@./bundle/build.sh $(APP_NAME) $(APP_BUILD_TAG) | tee -a $(LOGF)

.PHONY: deploy
deploy: bundle
	@echo '***' | tee -a $(LOGF)
	@echo '*** Build: $(APP_NAME) $(APP_BUILD_TAG)' | tee -a $(LOGF)
	@echo '***' | tee -a $(LOGF)
	@./deploy/build.sh $(APP_NAME) $(APP_BUILD_TAG) | tee -a $(LOGF)

# App

.PHONY: app
app: log-init docker/meteor-1.10.2
	@echo '***' | tee -a $(LOGF)
	@echo '*** Make: $(APP_NAME) $(APP_BUILD_TAG)' | tee -a $(LOGF)
	@echo '***' | tee -a $(LOGF)
	@./app/build.sh $(APP_NAME) $(APP_BUILD_TAG) | tee -a $(LOGF)
	@echo '***' | tee -a $(LOGF)
	@echo '*** Test: $(APP_NAME) $(APP_BUILD_TAG)' | tee -a $(LOGF)
	@echo '***' | tee -a $(LOGF)
	@TEST_FLAGS=$(TEST_FLAGS) ./test.sh $(APP_NAME) $(APP_BUILD_TAG) | tee -a $(LOGF)

.PHONY: publish-app
publish-app:
	@echo '***'
	@echo '*** Publish: $(APP_NAME) $(APP_BUILD_TAG)'
	@echo '***'
	@/srv/uws/deploy/host/ecr-login.sh us-east-1
	@/srv/uws/deploy/cluster/ecr-push.sh us-east-1 uws/app:deploy-$(APP_BUILD_TAG) uws:meteor-app-$(APP_BUILD_TAG)-$(BUILD_TAG)
	@/srv/uws/deploy/host/ecr-login.sh us-west-1
	@/srv/uws/deploy/cluster/ecr-push.sh us-west-1 uws/app:deploy-$(APP_BUILD_TAG) uws:meteor-app-$(APP_BUILD_TAG)-$(BUILD_TAG)

# Beta

.PHONY: beta
beta:
	@$(MAKE) app

.PHONY: publish-beta
publish-beta:
	@echo '***'
	@echo '*** Publish: $(APP_NAME) $(APP_BUILD_TAG)'
	@echo '***'
	@/srv/uws/deploy/host/ecr-login.sh us-east-2
	@/srv/uws/deploy/cluster/ecr-push.sh us-east-2 uws/beta:deploy-$(APP_BUILD_TAG) uws:meteor-$(APP_BUILD_TAG)-$(BUILD_TAG)

# Crowdsourcing

.PHONY: crowdsourcing
crowdsourcing: log-init docker/meteor-2.2
	@echo '***' | tee -a $(LOGF)
	@echo '*** Make: crowdsourcing $(APP_BUILD_TAG)' | tee -a $(LOGF)
	@echo '***' | tee -a $(LOGF)
	@./cs/build.sh $(APP_BUILD_TAG) | tee -a $(LOGF)

.PHONY: publish-crowdsourcing
publish-crowdsourcing:
	@echo '***'
	@echo '*** Publish: crowdsourcing $(APP_BUILD_TAG)'
	@echo '***'
	@/srv/uws/deploy/host/ecr-login.sh us-east-2
	@/srv/uws/deploy/cluster/ecr-push.sh us-east-2 uws/crowdsourcing:deploy-$(APP_BUILD_TAG) uws:meteor-crowdsourcing-$(APP_BUILD_TAG)-$(BUILD_TAG)
