#!/usr/bin/env bash

brew install zsh zsh-completions

#source <(k completion zsh)
# k completion zsh > ~/dotfiles/zsh/fpath/_kubectl

chsh -s $(which zsh)
