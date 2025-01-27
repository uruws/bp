BUILD_TAG     != git describe --tags --always
APP_NAME      ?= NOTSET
APP_BUILD_TAG ?= NOTSET
TEST_FLAGS    ?=
LOGS_DIR      ?= $(HOME)/logs
LOG_DATE      != date '+%y%m%d-%H%M%S'
LOGF          := $(LOGS_DIR)/$(APP_NAME)-build-$(LOG_DATE)-$(APP_BUILD_TAG).log
UWSREPO       ?= /opt/uws/src/uws

.PHONY: default
default:
	@$(MAKE) bootstrap

.PHONY: all
all:
	@$(MAKE) docker/base
	@$(MAKE) bootstrap
	@$(MAKE) devel

.PHONY: bootstrap
bootstrap:
	@$(MAKE) meteor

#
# cleanup
#

.PHONY: clean
clean:
	@rm -rf ./build ./tmp ./__pycache__

.PHONY: prune
prune:
	@docker system prune -f

#
# upgrades
#

.PHONY: upgrades
upgrades:
	@UWSREPO=$(UWSREPO) ./docker/upgrades-all.sh

.PHONY: upgrades-check
upgrades-check:
	@$(UWSREPO)/docker/upgrades.py --check

#
# devel image
#

.PHONY: devel
devel:
	@./docker/devel/build.sh

#
# Internal checks
#

.PHONY: check-all
check-all:
	@$(MAKE) check
	@$(MAKE) meteor-check

.PHONY: check
check:
	@./docker/devel/cmd.sh ./test/check.sh

.PHONY: check-meteor
check-meteor:
	@./check.sh

.PHONY: meteor-check
meteor-check:
	@$(MAKE) check-latest APP_BUILD_TAG=99.0
	@$(MAKE) check-devel APP_BUILD_TAG=99.0

.PHONY: publish-meteor-check
publish-meteor-check:
	@echo 'publish-meteor-check'

#
# Base image
#

.PHONY: docker/base
docker/base:
	@echo '***'
	@echo '*** Build: base image'
	@echo '***'
	@./docker/base/build.sh

#
# Meteor
#

.PHONY: meteor
meteor:
	@$(MAKE) docker/meteor
	@$(MAKE) docker/meteor-devel

.PHONY: docker/meteor
docker/meteor:
	@$(MAKE) docker/base
	@echo '***'
	@echo '*** Build: meteor'
	@echo '***'
	@./docker/meteor/build.sh

.PHONY: check-latest
check-latest:
	@$(MAKE) docker/meteor
	@echo '***'
	@echo '*** Make: meteor-check latest $(APP_BUILD_TAG)'
	@echo '***'
	@./docker/meteor/check/build.sh $(APP_BUILD_TAG)
	@./test.sh meteor-check $(APP_BUILD_TAG)

#
# Meteor devel
#

.PHONY: docker/meteor-devel
docker/meteor-devel:
	@$(MAKE) docker/meteor
	@echo '***'
	@echo '*** Build: meteor devel'
	@echo '***'
	@./docker/meteor-devel/build.sh

.PHONY: check-devel
check-devel:
	@$(MAKE) docker/meteor-devel
	@echo '***'
	@echo '*** Make: meteor-check devel $(APP_BUILD_TAG)'
	@echo '***'
	@./docker/meteor-devel/check/build.sh $(APP_BUILD_TAG)
	@./test.sh meteor-check $(APP_BUILD_TAG)

#
# Deploy and intermediate images
#

# install deps
.PHONY: install
install:
	@date -R | tee -a $(LOGF)
	@echo '***' | tee -a $(LOGF)
	@echo '*** NPM install: $(APP_NAME) $(APP_BUILD_TAG)' | tee -a $(LOGF)
	@echo '***' | tee -a $(LOGF)
	@./install/build.sh $(APP_NAME) $(APP_BUILD_TAG) | tee -a $(LOGF)
	@date -R | tee -a $(LOGF)

# compile
.PHONY: bundle
bundle:
	@$(MAKE) install
	@date -R | tee -a $(LOGF)
	@echo '***' | tee -a $(LOGF)
	@echo '*** Meteor bundle: $(APP_NAME) $(APP_BUILD_TAG)' | tee -a $(LOGF)
	@echo '***' | tee -a $(LOGF)
	@./bundle/build.sh $(APP_NAME) $(APP_BUILD_TAG) | tee -a $(LOGF)
	@date -R | tee -a $(LOGF)

# deploy setup
.PHONY: deploy
deploy:
	@$(MAKE) bundle
	@echo '***' | tee -a $(LOGF)
	@echo '*** Build: $(APP_NAME) $(APP_BUILD_TAG)' | tee -a $(LOGF)
	@echo '***' | tee -a $(LOGF)
	@./deploy/build.sh $(APP_NAME) $(APP_BUILD_TAG) | tee -a $(LOGF)
	@date -R | tee -a $(LOGF)

#
# App
#

.PHONY: app
app:
	@mkdir -vp $(LOGS_DIR)
	@date -R | tee $(LOGF)
	@echo '***' | tee -a $(LOGF)
	@echo '*** Make: $(APP_NAME) $(APP_BUILD_TAG)' | tee -a $(LOGF)
	@echo '***' | tee -a $(LOGF)
	@./app/build.sh $(APP_NAME) $(APP_BUILD_TAG) | tee -a $(LOGF)
	@date -R | tee -a $(LOGF)
#~ 	@echo '***' | tee -a $(LOGF)
#~ 	@echo '*** Test: $(APP_NAME) $(APP_BUILD_TAG)' | tee -a $(LOGF)
#~ 	@echo '***' | tee -a $(LOGF)
#~ 	@TEST_FLAGS=$(TEST_FLAGS) ./test.sh $(APP_NAME) $(APP_BUILD_TAG) | tee -a $(LOGF)

.PHONY: publish-app
publish-app:
	@echo '***'
	@echo '*** Publish: $(APP_NAME) $(APP_BUILD_TAG)'
	@echo '***'
	@./publish.sh uws/app:deploy-$(APP_BUILD_TAG) uws:meteor-app-$(APP_BUILD_TAG)-$(BUILD_TAG)

#
# Beta
#

.PHONY: beta
beta:
	@$(MAKE) app

.PHONY: publish-beta
publish-beta:
	@echo '***'
	@echo '*** Publish: $(APP_NAME) $(APP_BUILD_TAG)'
	@echo '***'
	@./publish.sh uws/beta:deploy-$(APP_BUILD_TAG) uws:meteor-$(APP_BUILD_TAG)-$(BUILD_TAG)

#
# Crowdsourcing
#

.PHONY: crowdsourcing
crowdsourcing:
	@mkdir -vp $(LOGS_DIR)
	@date -R >$(LOGF)
	@echo '***' | tee -a $(LOGF)
	@echo '*** Make: crowdsourcing $(APP_BUILD_TAG)' | tee -a $(LOGF)
	@echo '***' | tee -a $(LOGF)
	@./cs/build.sh $(APP_BUILD_TAG) | tee -a $(LOGF)

.PHONY: publish-crowdsourcing
publish-crowdsourcing:
	@echo '***'
	@echo '*** Publish: crowdsourcing $(APP_BUILD_TAG)'
	@echo '***'
	@./publish.sh uws/crowdsourcing:deploy-$(APP_BUILD_TAG) uws:meteor-crowdsourcing-$(APP_BUILD_TAG)-$(BUILD_TAG)

#
# Infra-UI
#

.PHONY: infra-ui
infra-ui:
	@mkdir -vp $(LOGS_DIR)
	@date -R >$(LOGF)
	@echo '***' | tee -a $(LOGF)
	@echo '*** Make: infra-ui $(APP_BUILD_TAG)' | tee -a $(LOGF)
	@echo '***' | tee -a $(LOGF)
	@./infra-ui/build.sh $(APP_BUILD_TAG) | tee -a $(LOGF)

.PHONY: publish-infra-ui
publish-infra-ui:
	@echo '***'
	@echo '*** Publish: infra-ui $(APP_BUILD_TAG)'
	@echo '***'
	@./publish.sh uws/infra-ui:deploy-$(APP_BUILD_TAG) uws:meteor-infra-ui-$(APP_BUILD_TAG)-$(BUILD_TAG)

#
# meteor-vanilla
#

.PHONY: meteor-vanilla
meteor-vanilla:
	@mkdir -vp $(LOGS_DIR)
	@date -R >$(LOGF)
	@echo '***' | tee -a $(LOGF)
	@echo '*** Make: meteor-vanilla $(APP_BUILD_TAG)' | tee -a $(LOGF)
	@echo '***' | tee -a $(LOGF)
	@./meteor-vanilla/build.sh $(APP_BUILD_TAG) | tee -a $(LOGF)

.PHONY: publish-meteor-vanilla
publish-meteor-vanilla:
	@echo '***'
	@echo '*** Publish: meteor-vanilla $(APP_BUILD_TAG)'
	@echo '***'
	@./publish.sh uws/meteor-vanilla:deploy-$(APP_BUILD_TAG) uws:meteor-vanilla-$(APP_BUILD_TAG)-$(BUILD_TAG)
