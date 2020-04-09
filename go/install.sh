if test ! $(which gvm)
then
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
    source $HOME/.gvm/scripts/gvm
    gvm install go1.13
fi
