.PHONY: default
default: all

.PHONY: all
all: docker/base

.PHONY: docker/base
docker/base:
	@./docker/base/build.sh
