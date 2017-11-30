#!/bin/bash

set -ex

if [ ! -f /conf/.bootstrapped ]; then
  sentry upgrade --noinput
  sentry createuser --email=${SENTRY_ADMIN_USERNAME} --password=${SENTRY_ADMIN_PASSWORD} --no-password --superuser --no-input
  touch /conf/.bootstrapped

fi

sentry run worker &
sentry run cron &

exec "$@"
