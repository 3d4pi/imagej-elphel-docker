FROM debian:stretch

ARG user=3d4pi
ARG debian_mirror=deb.debian.org
RUN sed -r -i -e s/deb.debian.org/$debian_mirror/ /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y --force-yes \
      wget \
      openjdk-8-jdk-headless \
 && useradd $user -m

ARG fiji=fiji-linux64-20140602.tar.gz
ADD $fiji /opt

ARG commit=4cc8de87939a4b629c685b0a06d7b26435c2e74b
RUN wget -O - https://github.com/3d4pi/imagej-elphel/archive/$commit.tar.gz | tar zxv -C /opt \
 && mv /opt/imagej-elphel-$commit /opt/imagej-elphel \
 && ln -s /opt/imagej-elphel/src/main/java /opt/Fiji.app/plugins/Elphel \
 && ln -s /opt/Fiji.app/ImageJ-linux64 /usr/bin/ \
 && chown $user.$user /opt/imagej-elphel/ -R

USER $user
RUN /usr/bin/ImageJ-linux64 --headless --compile-and-run /opt/Fiji.app/plugins/Elphel/Eyesis_Correction.java

SHELL [ "/bin/bash", "-l" ]
