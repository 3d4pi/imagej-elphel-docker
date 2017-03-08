#!/bin/bash
[ -z "$DEBIAN_MIRROR" ] && DEBIAN_MIRROR=deb.debian.org
[ -z "$COMMIT" ] && COMMIT=4cc8de87939a4b629c685b0a06d7b26435c2e74b

wget -c http://fiji.sc/downloads/Life-Line/fiji-linux64-20140602.tar.gz || exit

echo building docker image
docker build \
  --build-arg debian_mirror=$DEBIAN_MIRROR \
  --build-arg commit=$COMMIT \
  -t imagej-elphel:$COMMIT \
  -t imagej-elphel:$(date +%s) \
  -t imagej-elphel:latest \
  ./

