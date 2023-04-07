#!/bin/bash

### install.sh:
###     git
###     vim
###
### Usage:
###     ./security_development_keys_generator.sh security_development_keys.conf
###
### Prerequisite:
###     Program specific key configuration file security_development_keys.conf must be updated.
###
### Author:
###     akrish10(Akshay Krishna Upendran)
###
### [2021] Visteon Corporation
### All Rights Reserved.
###

set -ex
if command sudo -v
then
  sudo apt -y update
  sudo apt -y upgrade
  sudo apt -y install vim
  sudo apt -y install curl
  sudo apt -y install python3
  sudo -k
fi

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
  ./starship_install.sh -b ~/.local/bin
  rm -rf starship_install.sh
fi

if [[ ! -d ~/.config ]]; then
  mkdir ~/.config
fi

if [[ -f ~/.bashrc ]]; then
	mv -f ~/.bashrc ~/.bashrc.bak
fi
cp -RT dotfiles/ ~/

## Load our default configuration
~/.local/bin/starship preset pastel-powerline > ~/.config/starship.toml
if ! command -v fzf &> /dev/null; then
rm -rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
fi

curl -ksS https://raw.githubusercontent.com/newren/git-filter-repo/main/git-filter-repo -o ~/.local/bin/git-filter-repo

echo "Please run source ~/.bashrc a few times to complete installation !"
