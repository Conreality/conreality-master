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

boot: .built
	$(DOCKER) run --rm -it -p22:22/tcp -p5432:5432/tcp $(IMAGE) init

exec-shell: .built
	$(DOCKER) run --rm -it $(IMAGE) /bin/sh

exec-dbus: .built
	$(DOCKER) run --rm -it $(IMAGE) dbus-daemon

exec-dropbear: .built
	$(DOCKER) run --rm -it -p22:22/tcp $(IMAGE) dropbear

exec-freeswitch: .built
	$(DOCKER) run --rm -it -p5060:5060 -p5080:5080 -p8021:8021/tcp -p16384-16484:16384-16484/udp $(IMAGE) freeswitch -c -np -nosql -nonat -nonatmap

exec-postgres: .built
	$(DOCKER) run --rm -it -p5432:5432/tcp $(IMAGE) postgres

exec-echod: .built
	$(DOCKER) run --rm -it -p1234:1234/tcp $(IMAGE) echod

.PHONY: check uninstall clean distclean mostlyclean
.PHONY: boot exec-shell exec-dbus exec-dropbear exec-freeswitch exec-postgres exec-echod
.SECONDARY:
.SUFFIXES:
