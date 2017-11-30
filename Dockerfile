FROM sentry:8

LABEL description='Setry local development server.'
LABEL maintainer='s.apostolico@gmail.com'

ENV SENTRY_ADMIN_USERNAME admin
ENV SENTRY_ADMIN_PASSWORD=""


VOLUME /conf

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["sentry", "run", "web"]
