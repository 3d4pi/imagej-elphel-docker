FROM debian:stretch
ARG debian_mirror=deb.debian.org
ARG fiji=fiji-linux64-20140602.tar.gz
ARG commit=ef54ded3ed058c03dfb204b5f02876f6f3f37ea
ARG user=3d4pi
ADD $fiji /opt
RUN sed -r -i -e s/deb.debian.org/$debian_mirror/ /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y --force-yes \
      wget \
      openjdk-8-jdk-headless \
 && wget -O - https://github.com/3d4pi/imagej-elphel/archive/$commit.tar.gz | tar zxv -C /opt \
 && mv /opt/imagej-elphel-$commit /opt/imagej-elphel \
 && ln -s /opt/imagej-elphel/src/main/java /opt/Fiji.app/plugins/Elphel \
 && ln -s /opt/Fiji.app/ImageJ-linux64 /usr/bin/ \
 && ImageJ-linux64 --headless --compile-and-run /opt/Fiji.app/plugins/Elphel/Eyesis_Correction.java
RUN useradd $user -m
USER $user
