#!/bin/sh
set -e

echo "load configurations"
FILE=/app/app.env
if [ -f $FILE ]; then
   source $FILE
else
   source app.env
fi

echo "run db migration"
DB_MIGRATION_PATH=/app/migration
if [ ! -f $DB_MIGRATION_PATH ]; then
   DB_MIGRATION_PATH=db/migration
fi

MIGRATE_TOOL_PATH=/app/migrate
if [ ! -f $MIGRATE_TOOL_PATH ]; then
   MIGRATE_TOOL_PATH=migrate
fi

$MIGRATE_TOOL_PATH -path $DB_MIGRATION_PATH -database "$DB_SOURCE" --verbose up

echo "start the app"
exec "$@"