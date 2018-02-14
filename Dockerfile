FROM alpine:3.7

LABEL maintainer="Arto Bendiken <arto@conreality.org>"

RUN apk add --no-cache erlang freeswitch pllua postgresql su-exec

ENV TZ="UTC"
ENV LANG="en_US.UTF-8"
ENV PGUSER="postgres"
ENV PGDATA="/srv/postgres"
VOLUME /srv
EXPOSE 5432

COPY .docker/entrypoint.sh .
COPY .docker/pg_ctl.sh /usr/local/bin/pg_ctl
COPY .docker/postgres.sh /usr/local/bin/postgres

ENTRYPOINT ["./entrypoint.sh"]
CMD ["/bin/sh"]
