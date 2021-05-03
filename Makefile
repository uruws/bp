.PHONY: default
default: all

.PHONY: all
all: docker/base docker/meteor app

.PHONY: docker/base
docker/base:
	@./docker/base/build.sh

.PHONY: docker/meteor
docker/meteor:
	@./docker/meteor/build.sh

.PHONY: app
app:
	@./app/build.sh
