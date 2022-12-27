#!/bin/bash
set -e
set -x

if [[ ! -d ~/.local ]]; then
  mkdir ~/.local
fi
if [[ ! -d ~/.local/bin ]]; then
  mkdir ~/.local/bin
fi

if ! command -v starship &> /dev/null
then
  curl -ksS https://starship.rs/install.sh -o starship_install.sh
  chmod +x starship_install.sh
  starship_install.sh -b ~/.local/bin
  rm -rf starship_install.sh
fi

if [[ ! -d ~/.config ]]; then
  mkdir ~/.config
fi

starship preset pastel-powerline > ~/.config/starship.toml

if [[ -f ~/.bashrc ]]; then
	mv -f ~/.bashrc ~/.bashrc.bak
fi
cp -RT dotfiles/ ~/
