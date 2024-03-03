IMAGE=hldtux/ps3dev

test:
	DOCKER_DEFAULT_PLATFORM=linux/amd64 docker run -i --rm -v "`pwd`:/src" -w /src ${IMAGE} ./libraries.sh

run:
	DOCKER_DEFAULT_PLATFORM=linux/amd64 docker run -it --rm -v "`pwd`:/src" -w /src ${IMAGE} bash

clean:
	rm -rf build