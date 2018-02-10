FROM alpine:3.7

LABEL maintainer="Arto Bendiken <arto@conreality.org>"

RUN apk add --no-cache erlang pllua postgresql

ENV LANG en_US.UTF-8

VOLUME /srv

COPY .docker/entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]
CMD ["/bin/sh"]
