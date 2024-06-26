FROM ubuntu:24.04

COPY . /app

ENV VALE_VERSION="2.3.0"

RUN apt-get update && apt-get install wget make  -y 

RUN  URL="https://github.com/errata-ai/vale/releases/download/v${VALE_VERSION}/vale_${VALE_VERSION}_Linux_64-bit.tar.gz" && \
    wget --quiet $URL --output-document vale.tar.gz && \
    tar -xzf vale.tar.gz && \
    chmod +x vale && \
    mv vale /usr/local/bin/

WORKDIR /app


CMD ["make", "tests"]