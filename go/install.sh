if test ! $(which g); then
    source $(dirname $0)/path.zsh
    curl -sSL https://raw.githubusercontent.com/stefanmaric/g/next/bin/g > $GOPATH/bin/g
    chmod +x $GOPATH/bin/g
    echo "g is installed, to uninstall simply remove it at $GOPATH/bin/go"
fi
