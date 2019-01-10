FROM sentry:9

LABEL description='Setry local development server.'
LABEL maintainer='s.apostolico@gmail.com'

ENV SENTRY_ADMIN_USERNAME ""
ENV SENTRY_ADMIN_PASSWORD ""
ENV SENTRY_SECRET_KEY ""
ENV SENTRY_REDIS_HOST ""
ENV SENTRY_DB_USER ""
ENV SENTRY_POSTGRES_HOST ""
ENV SENTRY_DB_PASSWORD ""
ENV START_WEB "true"
ENV START_CRON "true"
ENV START_WORKER "true"
ENV SUPERVISOR_USER ""
ENV SUPERVISOR_PWD ""
ENV SENTRY_EMAIL_HOST ""
ENV SENTRY_EMAIL_PASSWORD ""
ENV SENTRY_EMAIL_USER ""
ENV SENTRY_EMAIL_PORT "25"

RUN pip2 install supervisor

ADD entrypoint.sh /entrypoint.sh
ADD supervisord.conf /etc/supervisord.conf
RUN chmod +x /entrypoint.sh \
    && mkdir /logs \
    && chown sentry /logs

EXPOSE 9000
EXPOSE 15000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["start"]
