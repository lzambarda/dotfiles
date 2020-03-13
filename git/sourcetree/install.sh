if test ! "$(uname)" = "Darwin"
  then
  exit 0
fi
ln -sf "$DOTFILES/git/sourcetree/actions.plist" "$HOME/Library/Application Support/SourceTree/actions.plist"
