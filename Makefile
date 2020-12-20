VERSION=`git rev-parse --short HEAD`
flags=-ldflags="-s -w -X main.version=${VERSION}"

all: vet build

vet:
	go vet .

build:
	go clean; rm -rf pkg; go build -o httpgo ${flags}

build_debug:
	go clean; rm -rf pkg; go build -o httpgo ${flags} -gcflags="-m -m"

build_all: build_osx build_linux build

build_osx:
	go clean; rm -rf pkg httpgo_osx; GOOS=darwin go build -o httpgo ${flags}

build_linux:
	go clean; rm -rf pkg httpgo_linux; GOOS=linux go build -o httpgo ${flags}

build_power8:
	go clean; rm -rf pkg httpgo_power8; GOARCH=ppc64le GOOS=linux go build -o httpgo ${flags}

build_arm64:
	go clean; rm -rf pkg httpgo_arm64; GOARCH=arm64 GOOS=linux go build -o httpgo ${flags}

build_windows:
	go clean; rm -rf pkg httpgo.exe; GOARCH=amd64 GOOS=windows go build -o httpgo ${flags}

install:
	go install

clean:
	go clean; rm -rf pkg

test : test1

test1:
	go test -v -bench=.
