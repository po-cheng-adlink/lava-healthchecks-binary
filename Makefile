download:
	git clone https://github.com/BayLibre/lava-healthchecks-binary.git || :
	cp -r -p lava-healthchecks-binary/mainline mainline
	cp -r -p lava-healthchecks-binary/images images
	cp -r -p lava-healthchecks-binary/next next
	cp -r -p lava-healthchecks-binary/stable stable

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
