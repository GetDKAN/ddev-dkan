#ddev-generated

ARG BASE_IMAGE
FROM $BASE_IMAGE

RUN apt-get update && apt-get upgrade \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y doxygen \
  && apt-get clean && apt-get autoclean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /data
VOLUME ["/data"]
