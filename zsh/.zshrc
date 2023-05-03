# zsh

# add a function path
fpath+=( $HOME/dotfiles/zsh/fpath )

# load all stack functions (from $fpath)
autoload -U compaudit compinit

# Path to your oh-my-zsh installation.
export ZSH="$HOME/dotfiles/zsh/.oh-my-zsh"

ZSH_THEME="oxide"

plugins=(zsh-autosuggestions)

if [ -f $ZSH/oh-my-zsh.sh ]; then
    source $ZSH/oh-my-zsh.sh
else
    echo "dotfiles: oh my zsh not installed"
fi

export DOTFILES=$HOME/dotfiles

# Set sublime as default visual editor
export VISUAL="wafer-thin"
export EDITOR=$VISUAL

# Do not share history between sessions
unsetopt SHARE_HISTORY

# source the path.zsh files first
for file in $(find $DOTFILES -mindepth 2 -maxdepth 4 -not -path '*.git*' -name path.zsh); do
    source $file
done

# source all zsh index files
for file in $(find $DOTFILES -mindepth 2 -maxdepth 4 -not -path '*.git*' -name index.zsh); do
    source $file
done

# Code for once a day evaluation
if [ ! -f $DOTFILES/onceaday ] || [ $(find $DOTFILES -mtime +0 -name "onceaday") ]; then
    touch -t $(date +%Y%m%d0000) $DOTFILES/onceaday # Set to beginning of today
    echo "Checking dotfiles updates..."
    git -C ~/dotfiles pull
    checkgo
fi

kao
