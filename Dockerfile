FROM golang:alpine AS builder

ENV GOCRYPTFS_VERSION v2.5.4
ENV GOPATH /go

RUN apk add --no-cache bash gcc git libc-dev openssl-dev

WORKDIR ${GOPATH}/src/github.com/rfjakob/gocryptfs

RUN git clone https://github.com/rfjakob/gocryptfs.git .
RUN git checkout "$GOCRYPTFS_VERSION"

RUN ./build.bash

RUN mv "${GOPATH}/bin/gocryptfs" /usr/local/bin/gocryptfs

# ---------------------------------------------------------------

FROM alpine:latest

ENV MOUNT_OPTIONS="-allow_other -nosyslog" \
    UNMOUNT_OPTIONS="-u -z"

COPY --from=builder /usr/local/bin/gocryptfs /usr/local/bin/gocryptfs

RUN apk --no-cache add fuse bash

RUN echo user_allow_other >> /etc/fuse.conf

COPY run.sh run.sh
RUN chmod +x run.sh

CMD ["./run.sh"]
