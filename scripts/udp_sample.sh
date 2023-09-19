#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
REPO_ROOT_DIR=$(cd "$SCRIPT_DIR/.." && pwd)

# Run server
$REPO_ROOT_DIR/build/src/sample/server/udp_server &

# Run client
sleep 1
$REPO_ROOT_DIR/build/src/sample/client/udp_client

wait
