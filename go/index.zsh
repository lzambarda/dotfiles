checkgo() {
    goroot="/usr/local"
    version=$(go version 2>/dev/null | cut -d' ' -f 3)
    if [ -z "$version" ]; then
        version="no go :("
    fi
    latest_version=$(curl -fsSL "https://golang.org/VERSION?m=text" | head -n1)
    if [ "$latest_version" = "$version" ]; then
        return 0
    fi
    # Silently exit if an error occurred
    if [ -z "$latest_version" ]; then
        return 0
    fi
    read "choice?Go version $latest_version is available. You have $version, do you want to install it? (y/n): "
    case "$choice" in
        y|Y|yes|YES ) echo "< yes";;
        n|N|no|NO ) echo "< no"; return 0;;
        * ) echo "Huh?"; return 0;;
    esac
    # Assert directory first
    cusr=$(whoami)
    if [ ! -d "$goroot/go" ]; then
        echo "Creating $goroot/go..."
        sudo mkdir "$goroot/go"
    fi
    if [ ! -O "$goroot/go" ]; then
        echo "$goroot/go needs to be owned by $cusr, chowning it..."
        sudo chown $cusr "$goroot/go"
    fi
    # Download go version
    release_file="$latest_version.darwin-arm64.tar.gz"
    curr=$PWD
    tmp=$(mktemp -d)
    cd $tmp || exit 1
    echo "Downloading https://go.dev/dl/$release_file ..." 
    curl -OL https://go.dev/dl/$release_file
    echo "Uninstalling current go..."
    rm -rf $goroot/go/*     
    echo "Unpacking in $goroot/go ..."
    tar -C $goroot -xzf $release_file
    echo "Cleaning tmp ..."
    rm -rf $tmp
    version=$(go version 2>/dev/null | cut -d' ' -f 3)
    cd $curr
    echo "Now, local Go version is $version"
}

gocover () {
        go test $@ -gcflags=-l -covermode=count -coverprofile=coverage.out ./...
        go tool cover -func=coverage.out | tail -n 1
        go tool cover -html=coverage.out
        rm -rf ./coverage.out
}