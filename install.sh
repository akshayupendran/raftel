#!/bin/bash
set -e
set -x
sudo apt update
sudo apt upgrade
if ! command -v starship &> /dev/null
then
  curl -ksS https://starship.rs/install.sh | sh
fi

if [[ ! -d ~/.config ]]; then
  mkdir ~/.config
fi

starship preset pastel-powerline > ~/.config/starship.toml

if [[ -f ~/.bashrc ]]; then
	mv -f ~/.bashrc ~/.bashrc.bak
fi
cp -RT dotfiles/ ~/
