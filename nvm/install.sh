if test ! $(which nvm); then
	if [ -d "$HOME/.nvm" ]; then
		exit 0
	fi
	# To allow lazy loading later	
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
fi
