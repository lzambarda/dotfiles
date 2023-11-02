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
    cat $1 | grep -Ev '^\s*#' | sed -E "s/^(export )?([0-9A-Z_]+)=.*$/set ${CYAN}\2${NC}/"
    #eval $(cat $1 | sed 's/^/export /')
    eval $(cat $1 | grep -E '^[0-9A-Z_]+=\S+' | sed 's/^/export /')
    eval $(cat $1 | grep -E '^export [0-9A-Z_]+=\S+')
}

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

kao() {
    emojis=(🚰 ☕️ 🥡 🍪 🍕 🍩 🍵 🥨 🍙 🌭 🍔 🥐 🥟 🥧 🍫 )
    index=$((1 + $RANDOM % ${#emojis[@]}))
    used=${emojis[$index]}
    case "$((RANDOM % 3))" in
        "0")
        cat <<EOF
 ,00>${used}
\|^|/
 | |
  \|
EOF
;;
        "1")
        cat <<EOF
 (\_(\\
 ( •ω•)
 /つ${used}つ
EOF
        ;;
        "2")
        cat <<EOF
  ⌒―-――⌒
 ( ･(ｪ)･)
 / つ${used}つ
(＿__つ_つ
EOF
        ;;
    esac
    case "$index" in
        "1") echo -e "\e[3mr/hydrohomies\e[0m";;
        "2") echo -e "\e[3mDamn fine coffee\e[0m";;
        "3") echo -e "\e[3mAnd then?\e[0m";;
    esac
}

njq() {
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "Usage is: njq <file> <js map reduce call>"
        return 1
    fi
    if [ $# -ne "2" ]; then
        echo "Error, usage is: njq <file> <js map reduce call>"
        return 1
    fi
    if [ ! -f $1 ]; then
        echo "Error, file does not exist or it is not a file: $1"
        return 1
    fi
    node -p "process.stdout.write(JSON.stringify(JSON.parse(require('fs').readFileSync('$1').toString())$2)+'\n')"
}

veof() {
    trap 'rm -f "$TMPFILE"' EXIT
    TMPFILE=$(mktemp) || return 1
    echo "Creating temp file $TMPFILE"
    ${EDITOR} $TMPFILE
    cat $TMPFILE
}

splitcsv() {
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "Usage is: splitcsv <file> <rows per chunk>"
        return 1
    fi
    if [ $# -ne "2" ]; then
        echo "Error, usage is: splitcsv <file> <rows per chunk>"
        return 1
    fi
    awk -v l=$2 '(NR==1){header=$0;next}
                (NR%l==2) {
                   close(f); 
                   f=sprintf("%s.%0.5d.csv",FILENAME,++c)
                   sub(/csv[.]/,"",f)
                   print header > f
                }
                {print > f}' $1
}

mergecsv() {
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "Usage is: mergecsv <files>"
        return 1
    fi
    if [ $# -lt "1" ]; then
        echo "Error, usage is: mergecsv <files>"
        return 1
    fi
    first=true
    output=""
    for f in $@; do
        if $first; then
            first=false
            output="merged_$f"
            echo "merging to $output"
            echo $f
            cp $f $output
        else
            echo $f
            tail -n+2 $f >> $output
        fi
    done
}
