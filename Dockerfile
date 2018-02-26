FROM alpine:edge
RUN echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories
RUN apk update && apk upgrade

LABEL maintainer="Arto Bendiken <arto@conreality.org>"

ENV TZ="UTC" LANG="en_US.UTF-8"
VOLUME /srv

ENV PGUSER="postgres" PGDATA="/srv/postgres"
EXPOSE 5432

COPY .docker/install.sh .docker/packages.txt /root/
RUN /root/install.sh /root/packages.txt

COPY .docker/configure.sh /root/
RUN /root/configure.sh

COPY .docker/etc/s6 /etc/s6/
COPY .docker/bin/* /usr/local/bin/
COPY .docker/sbin/* /usr/local/sbin/

COPY .docker/entrypoint.sh /tmp/
ENTRYPOINT ["/tmp/entrypoint.sh"]

CMD ["/bin/sh"]
