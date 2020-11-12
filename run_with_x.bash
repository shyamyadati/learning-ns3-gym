#!/bin/bash

image_name=$1

docker run --rm -it \
   --user=$(id -u) \
   --env="DISPLAY" \
   --workdir=/usr/work \
   --volume="$PWD":/usr/work \
   --volume="/etc/group:/etc/group:ro" \
   --volume="/etc/passwd:/etc/passwd:ro" \
   --volume="/etc/shadow:/etc/shadow:ro" \
   --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
   --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
   ${image_name} /bin/bash
