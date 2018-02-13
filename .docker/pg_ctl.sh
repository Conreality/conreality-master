#!/bin/sh
exec /sbin/su-exec "$PGUSER" /usr/bin/pg_ctl "$@"
