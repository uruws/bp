.PHONY: default
default: all

.PHONY: all
all: docker/base docker/meteor

.PHONY: docker/base
docker/base:
	@./docker/base/build.sh

.PHONY: docker/meteor
docker/meteor:
	@./docker/meteor/build.sh
