#!/bin/bash
[ -z "$DEBIAN_MIRROR" ] && DEBIAN_MIRROR=deb.debian.org

wget -c http://fiji.sc/downloads/Life-Line/fiji-linux64-20140602.tar.gz || exit

echo building docker image
sudo docker build \
  --build-arg debian_mirror=$DEBIAN_MIRROR \
  -t imagej-elphel:$(date +%s) \
  -t imagej-elphel:latest \
  ./

