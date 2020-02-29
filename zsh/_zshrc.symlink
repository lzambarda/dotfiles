export DOTFILES=$HOME/dotfiles

# source the path.zsh files first
for file in $(find $DOTFILES -mindepth 2 -maxdepth 2 -not -path '*.git*' -name path.zsh); do
    source $file
done

# source all zsh index files
for file in $(find $DOTFILES -mindepth 2 -maxdepth 2 -not -path '*.git*' -name index.zsh); do
    source $file
done
