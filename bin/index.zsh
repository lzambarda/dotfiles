senv() {
    if [ $# -ne "1" ]; then
        echo "Error, usage is: senv <file>"
        return 1
    fi
    if [ $1 = "--help" ]; then
        echo "Exports every variable inside an environment file in the format KEY=VALUE"
        return 0
    fi
    if [ ! -f $1 ]; then
        echo "Error, file does not exist or it is not a file: $1"
        return 1
    fi
    eval $(cat $1 | sed 's/^/export /')
}
