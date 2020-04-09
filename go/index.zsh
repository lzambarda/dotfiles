export GOPATH=$HOME/go
export GO111MODULE=on

gocover () {
        go test $@ -gcflags=-l -covermode=count -coverprofile=coverage.out ./...
        go tool cover -func=coverage.out | tail -n 1
        go tool cover -html=coverage.out
        rm -rf ./coverage.out
}
