#!/bin/bash
set -e
if ! command -v starship &> /dev/null
then
  curl -ksS https://starship.rs/install.sh | sh
fi

if [[ ! -d ~/.config ]]; then
  mkdir ~/.config
fi

starship preset pastel-powerline > ~/.config/starship.toml

if [ -f "${HOME}.bashrc" ]; then
	cp -f "${HOME}.bashrc" "${HOME}.bashrc.bak"
fi
cp -RT dotfiles/ ~/
