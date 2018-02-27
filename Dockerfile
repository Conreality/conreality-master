FROM conreality/docker:latest

LABEL maintainer="Arto Bendiken <arto@conreality.org>"

ENV PGUSER="postgres" PGDATA="/srv/postgres"
EXPOSE 22 5060 5080 5432 8021

COPY .docker/install.sh .docker/packages.txt /root/
RUN /root/install.sh /root/packages.txt

COPY .docker/configure.sh /root/
RUN /root/configure.sh

COPY .docker/etc /etc
COPY .docker/usr/local /usr/local

COPY .docker/entrypoint.sh /tmp/
ENTRYPOINT ["/tmp/entrypoint.sh"]

CMD ["init"]
