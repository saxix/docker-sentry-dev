#!/bin/bash

set -x


if [ "$*" == "start" ];then
    sentry upgrade --noinput || exit 1
    sentry cleanup || exit 1
    sentry createuser --email=${SENTRY_ADMIN_USERNAME} --password=${SENTRY_ADMIN_PASSWORD} --no-password --superuser --no-input 2>/dev/null
    if [ $? == 1 ];then
        echo "WARNING problem creating superuser"
    else
        echo "superuser succesfully created"
    fi
    exec supervisord --nodaemon -c /etc/supervisord.conf
else
    exec "$@"
fi
