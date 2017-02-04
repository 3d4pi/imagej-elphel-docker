FROM debian:stretch
ARG debian_mirror=deb.debian.org
ARG fiji=fiji-linux64-20140602.tar.gz
ARG commit=01246a6225a03bc108e9d3ea93fbc9663ca6fc49
ARG user=3d4pi
ADD $fiji /opt
RUN sed -r -i -e s/deb.debian.org/$debian_mirror/ /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y --force-yes \
      wget \
      openjdk-8-jdk-headless \
 && wget -O - https://github.com/Elphel/imagej-elphel/archive/$commit.tar.gz | tar zxv -C /opt \
 && mv /opt/imagej-elphel-$commit /opt/imagej-elphel \
 && ln -s /opt/imagej-elphel/src/main/java /opt/Fiji.app/plugins/Elphel \
 && ln -s /opt/Fiji.app/ImageJ-linux64 /usr/bin/ \
 && ImageJ-linux64 --headless --compile-and-run /opt/Fiji.app/plugins/Elphel/Eyesis_Correction.java
RUN useradd $user -m
USER $user
