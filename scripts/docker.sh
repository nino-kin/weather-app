#!/bin/bash
# vim: et ts=2 sts=2 sw=2
###########################################################################
#
# @(#) docker.sh
#
# Author: nino-kin
#
# Usage:
#   docker.sh [param]
#       (Optional)param: Docker option (e.g. setup, build, run, exec, etc.)
#
# Description:
#   This script provides simple commands so that you can manipulate 
#   the Docker easily.
#
###########################################################################
set -e

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
REPO_ROOT_DIR=$(cd "$SCRIPT_DIR/.." && pwd)
DOCKER_WORK_DIR="/app"

# Docker configuration
IMAGE_NAME="ninokin/build"
TAG="latest"
DOCKER_TAG="$IMAGE_NAME:$TAG"
DOCKER_CONTAINER="weather-runtime"
DOCKER_MOUNT_OPTION="--mount type=bind,source=$REPO_ROOT_DIR,target=$DOCKER_WORK_DIR"

# Build Docker image
setup() {
  if docker images "$IMAGE_NAME:$TAG" | grep "$IMAGE_NAME\s*$TAG"; then
    read -r -p "An image with the same name already exists. Do you want to delete it and create a new image? (y/n): " answer
    if [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
      # Remove the image
      docker rmi "$IMAGE_NAME:$TAG"
      echo "Remove successfully and create new one... "
    else
      echo "Aborted the process."
      exit 1
    fi
  fi

  docker build \
  -t "$DOCKER_TAG" \
  -f "$REPO_ROOT_DIR"/Dockerfile .
}

# Run Docker container
run() {
  docker run -d -it \
    --name $DOCKER_CONTAINER \
    $DOCKER_MOUNT_OPTION \
    $DOCKER_TAG \
    /bin/bash
}

# Execute a command in a running container
exec() {
  docker start $DOCKER_CONTAINER
  docker exec -it $DOCKER_CONTAINER bash
}

build() {
  mkdir -p $REPO_ROOT_DIR/build/
  docker run --rm -t \
  --name $DOCKER_CONTAINER \
  $DOCKER_MOUNT_OPTION \
  $DOCKER_TAG \
  bash -c "cd build && cmake .. && make"
}

kill() {
  docker kill $DOCKER_CONTAINER
}

remove-image() {
  docker rmi $DOCKER_TAG
}

if [ $# == 0 ]; then
  set -- --help
fi

param=$1
echo "${1}"
  case $param in
  --all | -all | --a | -a)
    setup
    build
  ;;
  --setup | -setup | setup | --docker-build | -docker-build | docker-build)
    setup
  ;;
  --run | -run | run | --docker-run | -docker-run | docker-run)
    run
  ;;
  --build | -build | build)
    build
  ;;
  --enter | -enter | enter | --exec | -exec | exec)
    exec
  ;;
  --kill | -kill | kill)
    kill
  ;;
  --remove-image | -remove-image | remove-image)
    remove-image
  ;;
  *)
    echo "USAGE: $0 [command]"
    echo " Commands:"
    echo "  setup     - Build an image from a Dockerfile"
    echo "  build     - Perform the build"
    echo "  enter     - Enter the docker container"
    echo ""
    echo "  all       - Perform all the above steps"
  ;;
  esac
