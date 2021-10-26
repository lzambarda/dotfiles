if test ! $(which gimme); then
    if test "$(uname)" = "Darwin"; then
        brew install gimme
    else
        curl -sL -o ~/bin/gimme https://raw.githubusercontent.com/travis-ci/gimme/master/gimme
        chmod +x ~/bin/gimme
    fi      
fi
