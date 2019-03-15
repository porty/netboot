FROM alpine:latest as base

RUN apk --no-cache add \
    bash \
    htop \
    dhclient \
    ca-certificates



FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y cpio && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /base

WORKDIR /

COPY --from=base / /base/

COPY generate.sh /

CMD ["/generate.sh"]
