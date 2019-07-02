FROM debian:latest
MAINTAINER lfelipedeoliveira, felipe@biome-hub.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y; \
    apt-get install apt-utils wget git g++ make zlib1g-dev gzip bzip2 cmake python --no-install-recommends pkg-config -y; \
    apt-get clean

RUN ln -s /usr/bin/python3 /usr/bin/python

# Download & install

 RUN git clone https://github.com/voutcn/megahit.git \
  && cd megahit \
  && mkdir -p build \
  && cd build \
  && cmake -DCMAKE_BUILD_TYPE=Release .. \
  && make -j4 \
  && make install \
  && cd / \
  && mkdir /opt/megahit \
  && mv megahit/build/* /opt/megahit \
  && rm -r megahit

ENV PATH /opt/megahit:$PATH

RUN megahit --test --no-hw-accel \
  && megahit --test --no-hw-accel --kmin-1pass


 