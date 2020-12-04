FROM golang:1.14-alpine as builder

# Fetch dependencies
RUN apk --no-cache add gcc git libc-dev make

# Create workdir
RUN mkdir -p /go/src/github.com/blaet/go-template

# Set workdir
WORKDIR /go/src/github.com/blaet/go-template

# Fetch modules
COPY go.mod go.sum /go/src/github.com/blaet/go-template/
RUN go mod download

# Build
COPY . /go/src/github.com/blaet/go-template
RUN make build

# Create final image
FROM alpine

EXPOSE 8080

ENV SERVER_LISTEN 0.0.0.0
ENV SERVER_PORT 8080

COPY --from=builder /go/src/github.com/blaet/go-template/tmp/default /default

ENTRYPOINT [ "/default" ]