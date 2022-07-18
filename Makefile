download:
	if [ -d lava-healthchecks-binary ]; then cd lava-healthchecks-binary; git pull; cd -; else git clone https://github.com/BayLibre/lava-healthchecks-binary.git; fi;
	rm -fr mainline images next stable
	cp -fr -p lava-healthchecks-binary/mainline mainline
	cp -fr -p lava-healthchecks-binary/images images
	cp -fr -p lava-healthchecks-binary/next next
	cp -fr -p lava-healthchecks-binary/stable stable

build: download
	docker-compose build

run: build
	docker-compose up

start: build
	docker-compose up -d

stop:
	docker-compose stop

status:
	docker-compose ps

restart:
	docker-compose stop
	docker-compose up -d

clean:
	docker-compose down

.PHONY: run start stop status restart clean
