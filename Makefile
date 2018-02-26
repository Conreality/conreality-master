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

init: .built
	$(DOCKER) run --rm -it -p22:22/tcp -p5432:5432/tcp $(IMAGE) s6-svscan /etc/s6

ssh: .built
	$(DOCKER) run --rm -it -p22:22/tcp $(IMAGE) sshd

echo: .built
	$(DOCKER) run --rm -it -p1234:1234/tcp $(IMAGE) echod

freeswitch: .built
	$(DOCKER) run --rm -it -p5060:5060 -p5080:5080 -p8021:8021/tcp -p16384-16484:16384-16484/udp $(IMAGE) freeswitch -np -nosql -nonat -nonatmap -c

postgres: .built
	$(DOCKER) run --rm -it -p5432:5432/tcp $(IMAGE) postgres

.PHONY: check uninstall clean distclean mostlyclean
.PHONY: shell init ssh echo freeswitch postgres
.SECONDARY:
.SUFFIXES:
