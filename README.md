Sentry local server
===================

A _"works for me"_ local development Sentry docker container.
 
It runs Sentry web/cron/worker in a single container but still depends on external redis/postgres 



    ENV SENTRY_ADMIN_USERNAME ""
    ENV SENTRY_ADMIN_PASSWORD ""
    ENV SENTRY_SECRET_KEY ""
    ENV SENTRY_REDIS_HOST ""

    ENV SENTRY_POSTGRES_HOST ""
    ENV SENTRY_DB_USER ""
    ENV SENTRY_DB_PASSWORD ""

    ENV SENTRY_EMAIL_HOST ""
    ENV SENTRY_EMAIL_PASSWORD ""
    ENV SENTRY_EMAIL_USER ""
    ENV SENTRY_EMAIL_PORT "25"

    ENV START_WEB "true"
    ENV START_CRON "true"
    ENV START_WORKER "true"

    ENV SUPERVISOR_USER ""
    ENV SUPERVISOR_PWD ""

