# imagej-elphel-docker
[Docker](https://www.docker.com) container to post-process [Elphel Eyesis camera](http://www3.elphel.com/eyesis4pi-393) footage using [imagej-elphel](https://github.com/elphel/imagej-elphel) plugins and [Fiji](https://fiji.sc/)

## Install

```
git clone https://github.com/3d4pi/imagej-elphel-docker
cd image-elphel-docker
COMMIT=4cc8de87939a4b629c685b0a06d7b26435c2e74b ./build.sh
```

## Example
```
docker run -it --name data.rawdata.00-0e-64-08-1e-39.master.1460401040.segment.1462366612.raw.14623695.module.1 -v /data/:/data:ro -v /data/rawdata/00-0e-64-08-1e-39/master/1460401040/segment/1462366612/tiles/:/tiles imagej-elphel:latest ImageJ-linux64 --headless --mem 7150m --run Eyesis_Correction prefs=/data/rawdata/00-0e-64-08-1e-39/master/1460401040/segment/1462366612/corrxml/data.rawdata.00-0e-64-08-1e-39.master.1460401040.segment.1462366612.raw.14623695.module.1.xml

```
