FROM ubuntu:bionic
MAINTAINER Adam Laza <ad.laza32@gmail.com>

RUN apt-get update && apt-get install software-properties-common -y
RUN add-apt-repository ppa:ubuntugis/ubuntugis-unstable

RUN apt-get update && apt-get install -y \
    git \
    python3 \
	python3-dev \
	python3-gdal \
	python3-pip \
    gdal-bin \
    proj-bin

RUN apt-get clean

RUN pip3 install \
    Shapely \
    rasterio \
    Fiona \
    owslib \
    pyproj

RUN pip3 install git+https://github.com/geopython/pywps.git@master

COPY processes /var/pywps/processes
COPY pywps.cfg /var/pywps/pywps.cfg
RUN mkdir /var/log/pywps
RUN mkdir /var/pywps/outputs -p
RUN mkdir /var/pywps/workdir -p

ENV PYTHONPATH "${PYTHONPATH}:/var/pywps"
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN pywps -c /var/pywps/pywps.cfg migrate
EXPOSE 5000
ENTRYPOINT ["pywps","-c", "/var/pywps/pywps.cfg", "start", "-b", "0.0.0.0"]
