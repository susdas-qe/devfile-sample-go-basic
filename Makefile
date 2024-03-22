# Disable CGO so that we always generate static binaries:
export CGO_ENABLED=0
export version="v2.1"

# Version of the project:
version=2.1
REL_VER=$(version)

.PHONY: build
build:
	go build -buildvcs=false -o ./releases/main

.PHONY: prepare_release
prepare_release:
	bash ./build/build
