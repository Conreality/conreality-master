FROM conreality/docker:latest

LABEL maintainer="Arto Bendiken <arto@conreality.org>"

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

CMD ["init"]
