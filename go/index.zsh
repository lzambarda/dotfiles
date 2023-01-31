export WANTED_GO_VERSION=1.19.5

setupgo() {
    if [ -z ${WANTED_GO_VERSION+x} ]; then
        echo "dotfiles: WANTED_GO_VERSION not set, skipping\n"
    else
        g set $WANTED_GO_VERSION
    fi
}

checkgo() {
    latest_version=$(g list-all | tail -n2 | head -1 | tr -d '>' | tr -d '[:space:]')
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
    previous_version=$WANTED_GO_VERSION
    sed -i '' "s/WANTED_GO_VERSION=$previous_version/WANTED_GO_VERSION=$latest_version/" ~/dotfiles/go/index.zsh
    echo "Config updated, installing..."
    export WANTED_GO_VERSION=$latest_version
    g install $WANTED_GO_VERSION
    g remove $previous_version
}

gocover () {
        go test $@ -gcflags=-l -covermode=count -coverprofile=coverage.out ./...
        go tool cover -func=coverage.out | tail -n 1
        go tool cover -html=coverage.out
        rm -rf ./coverage.out
}