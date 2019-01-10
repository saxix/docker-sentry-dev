CMD?=
VERSION=9-1
DOCKER_IMAGE?=saxix/sentry-localdev
DOCKERFILE?=Dockerfile
BUILD_OPTIONS?=--compress --rm
DEVELOP?="0"
WORKERS?=1
OPT?=

help:
	@echo 'Options:                                                       '
	@echo '   options can be passed via environment variables             '
	@echo '   TARGET:   package version and tag                           '
	@echo '   DEVELOP:  1=Use local code - 0=feth release from github     '
	@echo 'Usage:                                                         '
	@echo '   make clean            removes images and containers         '
	@echo '   make build            build container                       '
	@echo '   make test             test container                        '
	@echo '   make run              run container (only app)              '
	@echo '   make shell                                                  '
	@echo '   make push             push image to docker hub              '
	@echo '                                                               '

clean:
	docker rmi --force ${DOCKER_IMAGE}:${VERSION}

dev:
	DEVELOP=1 $(MAKE) build

build:
	docker build ${BUILD_OPTIONS} \
			-t ${DOCKER_IMAGE}:${VERSION} \
			-f ${DOCKERFILE} .
	@docker images | grep ${DOCKER_IMAGE}

.run:
	cd .. && docker run \
			-p 15000:15000 \
			-p 9000:9000 \
			-e SUPERVISOR_USER=${SUPERVISOR_USER} \
			-e SUPERVISOR_PWD=${SUPERVISOR_PWD} \
			-e SENTRY_ADMIN_USERNAME=admin \
			-e SENTRY_ADMIN_PASSWORD=123 \
			-e SENTRY_SECRET_KEY=Developmet-Sentry-Super-SecretKey \
			-e SENTRY_REDIS_HOST=${REDIS_SERVER} \
			-e SENTRY_DB_USER=${POSTGRES_USER} \
			-e SENTRY_POSTGRES_HOST=${POSTGRES_HOST} \
			-e SENTRY_DB_PASSWORD=${POSTGRES_PASSWORD} \
			--rm \
			${OPT} \
			-v /data/storage/sentry/conf:/conf \
			${DOCKER_IMAGE}:${VERSION} \
			${CMD}

run:
	CMD=start $(MAKE) .run

shell:
	OPT='-it' CMD='/bin/bash' $(MAKE) .run

release:
	echo ${DOCKER_PWD} | docker login -u ${DOCKER_USER} --password-stdin
	docker tag ${DOCKER_IMAGE}:${VERSION} ${DOCKER_IMAGE}:latest
	docker push ${DOCKER_IMAGE}:${VERSION}
	docker push ${DOCKER_IMAGE}:latest


.PHONY: run
