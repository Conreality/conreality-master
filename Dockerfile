FROM alpine:edge
RUN echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories
RUN apk update && apk upgrade

LABEL maintainer="Arto Bendiken <arto@conreality.org>"

ENV TZ="UTC" LANG="en_US.UTF-8"
VOLUME /srv

ENV PGUSER="postgres" PGDATA="/srv/postgres"
EXPOSE 5432

COPY .docker/pg_ctl.sh /usr/local/bin/pg_ctl
COPY .docker/postgres.sh /usr/local/bin/postgres
COPY .docker/install.sh ./
RUN ./install.sh

COPY .docker/entrypoint.sh ./
ENTRYPOINT ["./entrypoint.sh"]

CMD ["/bin/sh"]
