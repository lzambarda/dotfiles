loadenv() {
    if [ $# -ne "1" ]; then
        echo "Error, usage is: loadenv <file>"
        return 1
    fi
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "Exports every variable inside an environment file in the format KEY=VALUE"
        return 0
    fi
    if [ ! -f $1 ]; then
        echo "Error, file does not exist or it is not a file: $1"
        return 1
    fi
    CYAN=$'\033[0;36m'
	NC=$'\033[0m'
    cat $1 | grep -Ev '^\s*#' | sed -E "s/^([A-Z_]+)=.*$/set ${CYAN}\1${NC}/"
    #eval $(cat $1 | sed 's/^/export /')
    eval $(cat $1 | grep -E '^[A-Z_]+=\S+' | sed 's/^/export /')
}
