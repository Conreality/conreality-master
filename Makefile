DOCKER = docker
XZ     = xz

IMAGE   := conreality/master
VERSION := $(shell cat VERSION)
SOURCES := $(wildcard .docker/* .docker/*/*)

all: build

.built: Dockerfile $(SOURCES)
	$(DOCKER) build -t $(IMAGE) -f $< .
	@touch $@

dist.tar.xz: .built
	$(DOCKER) save $(IMAGE) | $(XZ) -1 > $@

build: .built

check:
	@echo "not implemented" && false # TODO

dist: dist.tar.xz

install: .built

uninstall:
	$(DOCKER) image rm $(IMAGE) || true

clean:
	@rm -f .built *~

distclean: clean

mostlyclean: clean

shell: .built
	$(DOCKER) run --rm -it $(IMAGE) /bin/sh

.PHONY: check uninstall clean distclean mostlyclean
.PHONY: shell
.SECONDARY:
.SUFFIXES:
