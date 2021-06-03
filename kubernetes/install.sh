if test ! $(which helm)
then
	echo "dotfiles: installing helm..."
	brew install helm
fi

if test ! $(which kind)
then
	echo "dotfiles: installing kind..."
	curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.8.1/kind-$(uname)-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
fi

if test ! $(which kubectx)
then
	echo "dotfiles: installing kubectx..."
	brew install kubectx
fi
