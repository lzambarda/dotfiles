export GOPATH=$HOME/go
export GO111MODULE=on
export GOPROXY=direct # For compatibility with gimme
export GOSUMDB=off    # For compatibility with gimme
export WANTED_GO_VERSION=1.17.2

setupgimme() {
    if [ -z ${WANTED_GO_VERSION+x} ]; then
        echo "dotfiles: GIMME_DEFAULT_GO_VERSION not set, skipping\n"
    else
        # Too slow for now
    	# if [ -z "$(gimme list &>/dev/null | grep $WANTED_GO_VERSION)" ]; then
    	#  	echo "dotfiles: Downloading go ${WANTED_GO_VERSION}..."
    	# fi
        eval "$(gimme $WANTED_GO_VERSION)" 2>/dev/null
    fi
}

checkgo() {
    latest_version=$(gimme --known | tail -n1)
    if [ "$latest_version" = "$WANTED_GO_VERSION" ]; then
        return 0
    fi
    read "choice?Go version $latest_version is available. Do you want to install it? (y/n): "
    case "$choice" in
        y|Y|yes|YES ) echo "< yes";;
        n|N|no|NO ) echo "< no"; return 0;;
        * ) echo "Huh?"; return 0;;
    esac
    # Update configfile
    sed -i '' "s/WANTED_GO_VERSION=$WANTED_GO_VERSION/WANTED_GO_VERSION=$latest_version/" ~/dotfiles/go/index.zsh
    echo "Config updated, installing..."
    export WANTED_GO_VERSION=$latest_version
    setupgimme
}

gocover () {
        go test $@ -gcflags=-l -covermode=count -coverprofile=coverage.out ./...
        go tool cover -func=coverage.out | tail -n 1
        go tool cover -html=coverage.out
        rm -rf ./coverage.out
}

