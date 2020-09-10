#!/usr/bin/env bash

brew install zsh zsh-completions

#source <(k completion zsh)
# k completion zsh > ~/dotfiles/zsh/fpath/_kubectl


if [ -z $(grep "$(which zsh)" /etc/shells) ]; then
	echo "Registering $(which zsh) in /etc/shells ..."
	sudo sh -c "echo $(which zsh) >> /etc/shells"
fi

chsh -s $(which zsh)
