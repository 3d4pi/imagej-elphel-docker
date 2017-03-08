FROM debian:stretch-slim

ARG user=3d4pi
ARG debian_mirror=deb.debian.org
RUN sed -r -i -e s/deb.debian.org/$debian_mirror/ /etc/apt/sources.list \
 && mkdir -p /usr/share/man/man1/ \
 && apt-get update \
 && apt-get install -y --force-yes \
      wget \
      openjdk-8-jdk-headless \
 && useradd $user -m

ARG fiji
ADD $fiji /opt

ARG commit
RUN wget -O - https://github.com/3d4pi/imagej-elphel/archive/$commit.tar.gz | tar zxv -C /opt \
 && mv /opt/imagej-elphel-$commit /opt/imagej-elphel \
 && ln -s /opt/imagej-elphel/src/main/java /opt/Fiji.app/plugins/Elphel \
 && ln -s /opt/Fiji.app/ImageJ-linux64 /usr/bin/ \
 && chown $user.$user /opt/imagej-elphel/ -R

USER $user
RUN /usr/bin/ImageJ-linux64 --headless --compile-and-run /opt/Fiji.app/plugins/Elphel/Eyesis_Correction.java

SHELL [ "/bin/bash", "-l" ]
