PKG = github.com/blaet/go-template
BINNAME = default
OUTBINNAME = ${BINNAME}
GOBUILD = go build -ldflags '-X main.gitTag=${GITTAG} -X main.buildDate=${BUILDDATE}'
BUILDDATE = $(shell date '+%Y%m%d-%H%M')
GITTAG = $(shell git rev-parse --short HEAD)
ifeq ($(GITTAG),)
GITTAG := devils
endif
SRC = $(shell pwd)
GOFILES = $(shell find . -type f -name '*.go' -not -path "./vendor/*")

build:
	${GOBUILD} -o tmp/${OUTBINNAME} ${PKG}/cmd/${BINNAME}

.PHONY: build
