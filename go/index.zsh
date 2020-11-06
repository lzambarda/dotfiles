export GOPATH=$HOME/go
export GO111MODULE=auto
export GOPROXY=direct # For compatibility with gimme
export GOSUMDB=off    # For compatibility with gimme
export GIMME_DEFAULT_GO_VERSION=1.14.1

setupgimme() {
    if [ -z ${GIMME_DEFAULT_GO_VERSION+x} ]; then
        echo "dotfiles: GIMME_DEFAULT_GO_VERSION not set, skipping\n"
    else
    	echo "dotfiles: Downloading go ${GIMME_DEFAULT_GO_VERSION}..."
        eval "$(gimme $GIMME_DEFAULT_GO_VERSION)" 2>/dev/null
    fi
}

gocover () {
        go test $@ -gcflags=-l -covermode=count -coverprofile=coverage.out ./...
        go tool cover -func=coverage.out | tail -n 1
        go tool cover -html=coverage.out
        rm -rf ./coverage.out
}
