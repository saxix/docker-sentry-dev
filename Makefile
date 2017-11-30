DATADIR?=/data/devpi_index
BACKUP?=/data/BACKUP
USER=saxix
IMAGE=sentry-localdev

.PHONY: upgrade

clean:
	-@docker rmi ${USER}/${IMAGE}

build:
	docker build -t ${USER}/${IMAGE} --force-rm --rm  .

run: build
	docker run --rm ${USER}/${IMAGE}

bash:
	docker run --rm ${USER}/${IMAGE}:`cat VERSION` /bin/bash


test: clean build
	docker run -p 16379:6379 --rm ${USER}/${IMAGE}:`cat VERSION`


tag: build
	docker tag ${USER}/${IMAGE}:latest ${USER}/${IMAGE}:`cat VERSION`


release: tag
	docker push ${USER}/${IMAGE}:latest
	docker push ${USER}/${IMAGE}:`cat VERSION`


docker-cleanup:
	@if [ -n "$(docker ps -a -q)" ];then docker rm $(docker ps -a -q) -f;fi
	@# 1. Make sure that exited containers are deleted.
	-@docker rm -v `docker ps -a -q -f status=exited` 2>/dev/null
	@# 2. Remove unwanted ‘dangling’ images.
	-@docker rmi `docker images -f "dangling=true" -q`  2>/dev/null
	@# 3. Clean ‘vfs’ directory?
	-@docker volume rm `docker volume ls -qf dangling=true`  2>/dev/null

