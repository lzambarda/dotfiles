#!/usr/bin/env bash

echo "Installing zsh, zsh-completions..."
brew install zsh zsh-completions

#source <(k completion zsh)
# k completion zsh > ~/dotfiles/zsh/fpath/_kubectl

if [ -z $(grep "$(which zsh)" /etc/shells) ]; then
	echo "Registering $(which zsh) in /etc/shells ..."
	sudo sh -c "echo $(which zsh) >> /etc/shells"
fi

if [ -z $(echo $SHELL | grep zsh) ]; then
    echo "Setting zsh as the default shell..."
    chsh -s $(which zsh)
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/dotfiles/zsh/.oh-my-zsh"

if [ ! -f $ZSH/oh-my-zsh.sh ]; then
    echo "Installing oh my zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "Installing auto zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

