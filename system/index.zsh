export EDITOR='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl -wn'

# GRC colorizes nifty unix tools all over the place
if (( $+commands[grc] )) && (( $+commands[brew] ))
then
  source `brew --prefix`/etc/grc.bashrc
fi
