FROM alpine:3.7

LABEL maintainer="Arto Bendiken <arto@conreality.org>"

ENV LANG en_US.UTF-8

RUN apk add --no-cache erlang pllua postgresql

VOLUME /srv

ENTRYPOINT ["/bin/sh"]
