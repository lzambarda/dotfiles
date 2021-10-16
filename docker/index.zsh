export DOCKER_BUILDKIT=1

docker_stopall() {
	docker stop $(docker ps -q)
}