# https://github.com/ravron/dotfiles/blob/2093bb4b257db221f31fa900cfc8cd394476a7cd/.bashrc#L233-L243
# nvm's setup is slow and I don't use it often. Lazy load it by wrapping it in
# a function by the same name. When first invoked in a session, unset the
# wrapper, load the real nvm, and invoke it with the provided parameters.
nvm() { 
	unset -f nvm
	_load_nvm
    nvm "$@"
}

# Same with node
node() {
	unset -f node
	_load_nvm
   	node "$@"
}

_load_nvm() {
	echo "dotfiles: loading nvm..."
	export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
}