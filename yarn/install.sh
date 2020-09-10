#!/usr/bin/env bash

if test ! $(which yarn)
then
	# curl -o- -L https://yarnpkg.com/install.sh | bash
  	brew install yarn
fi
