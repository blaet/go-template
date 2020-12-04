FROM golang:1.14-alpine as builder

# Fetch dependencies
RUN apk --no-cache add gcc make git libc-dev

# Set package name
ENV PKG github.com/blaet/go-template
ENV WORKDIR /go/src/$PKG/

# Create workdir
RUN mkdir -p ${WORKDIR}

# Set workdir
WORKDIR ${WORKDIR}

# Fetch 'air' tool
RUN go get -u github.com/cosmtrek/air && rm -r /root/.cache/*

EXPOSE 8080

ENV SERVER_LISTEN 0.0.0.0
ENV SERVER_PORT 8080

# Fetch modules
COPY go.mod go.sum ${WORKDIR}
RUN go mod download

CMD air
