#!/bin/bash

# Run server
./build/src/sample/server/udp_server &

# Run client
sleep 1
./build/src/sample/client/udp_client

wait
