NAME = testing
IMAGE = joatmon08/consul-watcher:latest

golang-build:
	GOOS=linux GOARCH=amd64 go build handler.go
	docker build -t $(IMAGE) -f Dockerfile.golang .

shell-build:
	docker build -t $(IMAGE) -f Dockerfile.shell .

run:
	docker run -d --name $(NAME) $(IMAGE)

watch:
	docker exec $(NAME) consul watch -type=key -key=foo /scripts/handler &