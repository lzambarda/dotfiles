if test ! "$(uname)" = "Darwin"
  then
  exit 0
fi

# https://www.sublimemerge.com/docs/packages
ln -sf "$DOTFILES/git/sublimemerge/Default.sublime-commands" "$HOME/Library/Application Support/Sublime Merge/Packages/User/Default.sublime-commands"
