#!/bin/bash

SCRIPT_PATH=$(dirname "$(realpath $0)")

docker run --rm -it -d \
  -e DISPLAY=$DISPLAY \
  -e QT_XKB_CONFIG_ROOT=/user/share/X11/xkb \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v teradici-client-config:/home/developer/.config \
  --network=host \
  `docker build -q -f ${SCRIPT_PATH}/Dockerfile ${SCRIPT_PATH}`
