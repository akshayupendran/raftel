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

#if command -v; then
  apt -yqq update
  apt -yqq upgrade
  if ! command -v add-apt-repository &> /dev/null; then
    apt -yqq install software-properties-common
  fi

# ToDo: Make sure libssl-dev is installed only once.
  for program in vim autoconf curl python3  clang-format clang-tidy clang gcc\
                 gdb openssl wget podman make man libssl-dev g++ git-lfs     \
                 git-crypt; do
    if ! command -v $program &> /dev/null; then
      apt -yqq install $program
    fi
  done;
  unset program;

  if ! command -v srec_cat &> /dev/null; then
    apt -yqq install srecord
  fi

  if ! command -v named &> /dev/null; then
    apt -yqq install bind9
  fi

  if ! command -v hexdump &> /dev/null; then
    apt -yqq install bsdmainutils
  fi

  if ! command -v lsb_release &> /dev/null; then
    apt -yqq install lsb-compat
  fi

#  -k
#fi

if [[ ! -f ~/.path ]]; then
  mv -f ~/.bashrc ~/.bashrc.bak
  cp -RT dotfiles/ ~/
fi

for folder in ~/.{local,local/bin,config}; do
  if [[ ! -d $folder ]]; then
    mkdir $folder
  fi
done;
unset folder;

if ! command -v starship &> /dev/null; then
  curl -ksS https://starship.rs/install.sh -o starship_install.sh
  chmod +x starship_install.sh
  ./starship_install.sh -y -b ~/.local/bin
  rm -f starship_install.sh
  apt install git-lfs
fi

if [[ ! -f ~/.config/starship.toml ]]; then
  ~/.local/bin/starship preset pastel-powerline > ~/.config/starship.toml
fi

if ! command -v fzf &> /dev/null; then
  rm -rf ~/.fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
fi

if [[ ! -f ~/.local/bin/git-filter-repo ]]; then
  curl -ksS https://raw.githubusercontent.com/newren/git-filter-repo/main/git-filter-repo -o ~/.local/bin/git-filter-repo
fi

if ! command -v rustc &> /dev/null; then
  curl --proto '=https' --tlsv1.2 -ksSf https://sh.rustup.rs -o temp.sh
  chmod +x temp.sh
  ./temp.sh -y
  rm -f temp.sh
fi

echo "Please run source ~/.bashrc a few times to complete installation !"
