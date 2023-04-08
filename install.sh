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

if command sudo -v; then
  sudo apt -yqq update
  sudo apt -yqq upgrade
  if ! command -v add-apt-repository &> /dev/null; then
    sudo apt -yqq install software-properties-common
  fi

  for program in vim autoconf curl python3  clang-format clang-tidy clang gcc \
                 gdb openssl  wget podman   ; do
    if ! command -v $program &> /dev/null; then
      sudo apt -yqq install $program
    fi
  done;
  unset program;
  
  if ! command -v srec_cat &> /dev/null; then
    sudo apt -yqq install srecord
  fi

  if ! command -v hexdump &> /dev/null; then
    sudo apt -yqq install bsdmainutils
  fi

  if ! command -v lsb_release &> /dev/null; then
    sudo apt -yqq install lsb-compat
  fi
  
  if ! command -v git-lfs &> /dev/null; then
    curl -ksS https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh -o script.deb.sh
    chmod +x script.deb.sh
    sudo ./script.deb.sh
    rm -f script.deb.sh
    sudo apt install git-lfs
  fi

  sudo -k
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
  sudo apt install git-lfs
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
