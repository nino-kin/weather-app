#!/bin/bash
# vim: et ts=2 sts=2 sw=2
###################################################################
# Script Name  : docker.sh
# Description  : Docker helper.
# Args         :
#     param: Docker option (e.g. setup, build, run, exec, etc.)
###################################################################
set -eu

REPO_NAME=$(basename -s .git "$(git config --get remote.origin.url)")
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
REPO_ROOT_DIR=$(cd "$SCRIPT_DIR/.." && pwd)
readonly DOCKER_WORK_DIR=$REPO_ROOT_DIR

# Docker configuration
readonly USER_NAME='nino-kin'
readonly IMAGE_NAME="$USER_NAME/$REPO_NAME"
readonly TAG="latest"
readonly DOCKER_TAG="$IMAGE_NAME:$TAG"
readonly DOCKER_CONTAINER="$REPO_NAME"
readonly DOCKER_MOUNT_OPTION="--mount type=bind,source=$REPO_ROOT_DIR,target=$DOCKER_WORK_DIR"

clean() {
  # Remove docker images, containers and network
  docker system prune
  docker builder prune -f
}

# Build Docker image
setup() {
  docker build -t ubuntubase -f tools/ubuntubase/Dockerfile .
  docker build -t vsocde -f tools/vscode/Dockerfile .
  docker build -t flutter -f tools/flutter/Dockerfile .
}

run() {
  docker run \
    --net=bridge \
    --shm-size=4096m \
    --rm \
    -t \
    -e DISPLAY \
    -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0 \
    -e PULSE_COOKIE=/tmp/pulse/cookie \
    -e PULSE_SERVER=unix:/tmp/pulse/native \
    -v /run/user/1000/pulse/native:/tmp/pulse/native \
    -v ~/.config/pulse/cookie:/tmp/pulse/cookie:ro \
    -e XMODIFIERS \
    -e GTK_IM_MODULE \
    -e QT_IM_MODULE \
    -e DefaultIMModule=fcitx \
    -e DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus \
    -v /run/user/1000/bus:/run/user/1000/bus \
    --privileged \
    -v ~/flutter_container:/home/user \
    -v /dev/bus/usb:/dev/bus/usb \
    -u `id -u` \
    flutter code --verbose
}

if [ $# == 0 ]; then
  set -- --help
fi

param=$1
echo "${1}"
  case $param in
  --all | -all | --a | -a)
    setup
    run
  ;;
  --clean | -clean | clean)
    clean
  ;;
  --setup | -setup | setup | --docker-build | -docker-build | docker-build)
    setup
  ;;
  --run | -run | run | --docker-run | -docker-run | docker-run)
    run
  ;;
  *)
    echo "USAGE: $0 [command]"
    echo " Commands:"
    echo "  setup      - Build image(s) from Dockerfile(s)"
    echo "  clean      - Clean all cache"
    echo "  run        - Run the docker container (-it mode)"
    echo ""
    echo "  all       - Perform all the above steps"
  ;;
  esac
