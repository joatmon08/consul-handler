NAME = testing
IMAGE = joatmon08/consul-watcher:latest

config-build:
	GOOS=linux GOARCH=amd64 go build handler.go
	docker build -t $(IMAGE) -f Dockerfile.config .

golang-build:
	GOOS=linux GOARCH=amd64 go build handler.go
	docker build -t $(IMAGE) -f Dockerfile.golang .

shell-build:
	docker build -t $(IMAGE) -f Dockerfile.shell .

run:
	docker run -d -p 8500:8500 --name $(NAME) $(IMAGE)

delete:
	docker rm -f testing

watch-key:
	docker exec $(NAME) consul watch -type=key -key=foo /scripts/handler &

watch-prefix:
	docker exec $(NAME) consul watch -type=keyprefix -prefix=foo /scripts/handler &
