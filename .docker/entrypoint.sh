#!/bin/sh

# See: https://dbus.freedesktop.org/doc/dbus-uuidgen.1.html
if [ ! -e /etc/machine-id ]; then
  /usr/bin/dbus-uuidgen --ensure=/etc/machine-id
fi

mkdir -p /etc/dropbear
chown root:root /etc/dropbear
chmod 700 /etc/dropbear
if [ ! -f /etc/dropbear/dropbear_ecdsa_host_key ]; then
  /usr/bin/dropbearkey -t ecdsa -f /etc/dropbear/dropbear_ecdsa_host_key
fi

# See: https://www.postgresql.org/docs/10/static/creating-cluster.html
# See: https://www.postgresql.org/docs/10/static/app-pg-ctl.html
# See: https://www.postgresql.org/docs/10/static/app-initdb.html
if [ -z "$(ls -1A "$PGDATA" 2>/dev/null)" ]; then
  mkdir -p "$PGDATA"
  chown -R "$PGUSER:$PGUSER" "$PGDATA"
  chmod 700 "$PGDATA"
  /sbin/su-exec "$PGUSER" /usr/bin/pg_ctl initdb -D "$PGDATA" -o "-U $PGUSER"
fi

# See: https://www.postgresql.org/docs/10/static/auth-pg-hba-conf.html
echo 'local all all trust' > "$PGDATA/pg_hba.conf"
echo 'host all all all trust' >> "$PGDATA/pg_hba.conf"

# See: https://www.postgresql.org/docs/10/static/config-setting.html
# See: https://www.postgresql.org/docs/10/static/runtime-config-connection.html
echo "listen_addresses='*'" >> "$PGDATA/postgresql.conf"

# See: https://www.postgresql.org/docs/10/static/server-start.html
mkdir -p /run/postgresql
chown -R "$PGUSER:$PGUSER" /run/postgresql
chmod 2775 /run/postgresql

exec "$@"
