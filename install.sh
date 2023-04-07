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

set -e

if command sudo -v; then
  sudo apt -qq update
  sudo apt -qq upgrade
	
	if ! command -v vim &> /dev/null
	then
		sudo apt -qq install vim
	fi

	if ! command -v curl &> /dev/null
	then
	  sudo apt -qq install curl
	fi
  	
	if ! command -v python3 &> /dev/null
	then
		sudo apt -qq install python3
	fi

	if ! command -v hexdump &> /dev/null
	then
		sudo apt -qq install bsdmainutils
	fi

  if ! command -v lsb_release &> /dev/null
	then
		sudo apt -qq install lsb-compat
	fi

	if ! command -v podman &> /dev/null
	then
		echo "!!!!!!Please manually install podman!!!!!"
	fi

	if ! command -v clang-format &> /dev/null
	then
		sudo apt -qq install clang-format
	fi

	if ! command -v clang &> /dev/null
	then
		sudo apt -qq install clang
	fi
  
  if ! command -v clang-tidy &> /dev/null
	then
		sudo apt -qq install clang-tidy
	fi
  
  sudo -k
fi

if [[ ! -d ~/.local ]]; then
  mkdir ~/.local
fi

if [[ ! -d ~/.local/bin ]]; then
  mkdir ~/.local/bin
fi

if ! command -v starship &> /dev/null; then
  curl -ksS https://starship.rs/install.sh -o starship_install.sh
  chmod +x starship_install.sh
  ./starship_install.sh -b ~/.local/bin
  rm -rf starship_install.sh
fi

if [[ ! -d ~/.config ]]; then
  mkdir ~/.config
fi

if [[ ! -f ~/.path ]]; then
	mv -f ~/.bashrc ~/.bashrc.bak
	cp -RT dotfiles/ ~/
fi

if [[ ! -f ~/.config/starship.toml ]]; then
	~/.local/bin/starship preset pastel-powerline > ~/.config/starship.toml
fi

if ! command -v fzf &> /dev/null; then
  rm -rf ~/.fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

if [[ ! -f ~/.local/bin/git-filter-repo ]]; then
  curl -ksS https://raw.githubusercontent.com/newren/git-filter-repo/main/git-filter-repo -o ~/.local/bin/git-filter-repo
fi

echo "Please run source ~/.bashrc a few times to complete installation !"
