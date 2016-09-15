### DRY THIS LATER - should be a global makefile of some sort ###

CONTAINER_NAME=$(shell basename $(shell pwd))
DOCKER_NAMESPACE=quay.io/yogaglo
IMAGE_NAME=$(shell basename $(shell pwd))
### uncomment this line to set TAG to the current branch's name by default
#TAG=$(shell git rev-parse --abbrev-ref HEAD)
TAG=latest

go:
	@echo "starting docker backend"
	@docker-machine start

### Images

# Build the Docker image
build:
	@docker build -t ${DOCKER_NAMESPACE}/${IMAGE_NAME}:${TAG} .

# Build the image without using cache (full rebuild) (much slower)
rebuild:
	@docker build --no-cache -t ${DOCKER_NAMESPACE}/${IMAGE_NAME}:${TAG} .

# pull an updated copy of the image
pull:
	@docker pull ${DOCKER_NAMESPACE}/${IMAGE_NAME}:${TAG}

# push the image to the repository
push: 
	@docker push ${DOCKER_NAMESPACE}/${IMAGE_NAME}:${TAG}


### Containers 

# Open a root shell to a running container
shell:
	-@docker exec -i -t ${CONTAINER_NAME} /bin/ash

# Stop the container
stop:
	-@docker stop ${CONTAINER_NAME}

# Remove the container
rm:
	-@docker rm ${CONTAINER_NAME}

# Stop and remove the container
clean: stop rm

# Stop, remove container, delete image.
full-clean-remove-images-yes-I-am-sure: clean
	-@docker rmi ${DOCKER_NAMESPACE}/${IMAGE_NAME}


#### SPECIFIC TO THIS PROJECT due to env.vars ###

# define application config to be passed from environment variables.
define CONFIG
endef

# Launch a Docker container with a *mounted* copy of the service.
run: clean
	@docker run -d \
		-p 8080:8080 \
		-v $(shell pwd)/:/opt/echo \
	${CONFIG} --name ${CONTAINER_NAME} ${DOCKER_NAMESPACE}/${IMAGE_NAME}:${TAG}
# Launch a Docker container with a baked-in copy of the service
run-baked: clean
	-p 8080:8080 \
	@docker run -d \
	${CONFIG}	--name ${CONTAINER_NAME} ${DOCKER_NAMESPACE}/${IMAGE_NAME}:${TAG}
