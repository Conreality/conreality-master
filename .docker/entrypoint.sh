#!/bin/sh

# See: https://www.postgresql.org/docs/10/static/creating-cluster.html
# See: https://www.postgresql.org/docs/10/static/app-pg-ctl.html
# See: https://www.postgresql.org/docs/10/static/app-initdb.html
mkdir -p "$PGDATA"
chown -R "$PGUSER:$PGUSER" "$PGDATA"
chmod 700 "$PGDATA"
su-exec "$PGUSER" pg_ctl -D "$PGDATA" -U "$PGUSER" initdb

# See: https://www.postgresql.org/docs/10/static/auth-pg-hba-conf.html
echo 'local all all trust' > "$PGDATA/pg_hba.conf"
echo 'host all all all trust' >> "$PGDATA/pg_hba.conf"

# See: https://www.postgresql.org/docs/10/static/server-start.html
mkdir -p /run/postgresql
chown -R "$PGUSER:$PGUSER" /run/postgresql
chmod 2775 /run/postgresql

exec "$@"
