#!/bin/bash

### install.sh:
###
### Usage:
###     ./install.sh
###
### Prerequisite:
###     Installation configuration file install.conf must be updated.
###
### Author:
###     akrish10(Akshay Krishna Upendran)
###

set -ex

# Source with global variables
source install.conf

# Requires sudo
if command sudo -v; then
  ## Install company specific internet proxy certificates if any
  sudo apt -yqq update
  if ! command -v update-ca-certificates &> /dev/null; then
    sudo apt -yqq install ca-certificates
  fi
  for l_local_var in "${g_cert[@]}"; do
    if [[ ! -f "/usr/local/share/ca-certificates/$(basename "${l_local_var}")" ]]; then
      sudo cp "${l_local_var}" /usr/local/share/ca-certificates
      sudo update-ca-certificates
    fi
  done;
  unset l_local_var;

  ## Install all ppa(s) defined
  if ! command -v add-apt-repository &> /dev/null; then
    sudo apt -yqq install software-properties-common
  fi
  for l_local_var in ${g_ppa}; do
    if ! grep -q "^deb .*$l_local_var" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
      sudo add-apt-repository ppa:"${l_local_var}" -y
    fi
  done;
  unset l_local_var;

  ## Install list of apt programs
  sudo apt -yqq update
  sudo apt -yqq upgrade
  for l_local_var in $g_apt_programs; do
    if ! command -v "${l_local_var}" &> /dev/null; then
      sudo apt -yqq install "${l_local_var}"
    fi
  done;
  unset l_local_var;
  ### Install second list of apt programs
  for l_local_var in "${!g_apt_programs_dict[@]}"; do
    if ! command -v ${g_apt_programs_dict[$l_local_var]} &> /dev/null; then
      sudo apt -yqq install "${l_local_var}"
    fi
  done;
  unset l_local_var;
  ### Install third list of apt programs
  for l_local_var in "${!g_apt_programs_dict_file[@]}"; do
    if [[ ! -f ${g_apt_programs_dict_file[$l_local_var]} ]]; then
      sudo apt -yqq install "${l_local_var}"
    fi
  done;
  unset l_local_var;
  # Always use python3
  sudo update-alternatives --remove python /usr/bin/python2
  sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10
  # Set TimeZone
  sudo timedatectl set-timezone "${g_timezone}"
  sudo -k
fi

# Dotfiles stowing - requires stow
if command -v stow &> /dev/null; then
  ## Dirty check via .path if path already exists. If exists dont install.
  if [[ ! -f ~/.wgetrc ]]; then
    if [[ -f ~/.bashrc ]]; then
      mv -f ~/.bashrc ~/.bashrc.bak
    fi
    if [[ -f ~/.gitconfig ]]; then
      mv -f ~/.gitconfig ~/.gitconfig.bak
    fi
    for l_folder in */ ; do\
      stow --dotfiles "$l_folder"
    done
    unset l_folder;
  fi
fi

for l_local_var in ~/.{local,local/bin,config}; do
  if [[ ! -d $l_local_var ]]; then
    mkdir $l_local_var
  fi
done;
unset l_local_var;

# Installation of starship -> Requires curl
if command -v curl &> /dev/null; then
  if ! command -v starship &> /dev/null; then
    curl -ksS https://starship.rs/install.sh -o starship_install.sh
    chmod +x starship_install.sh
    ./starship_install.sh -y -b ~/.local/bin
    rm -f starship_install.sh
  fi
fi

# If default starship config does not exist, then take pastel-powerline as default.
if [[ ! -f ~/.config/starship.toml ]]; then
  ~/.local/bin/starship preset pastel-powerline > ~/.config/starship.toml
fi

# Install FzF - better than apt version
if ! command -v fzf &> /dev/null; then
  rm -rf ~/.fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
fi

# Install Filter Repo
if [[ ! -f ~/.local/bin/git-filter-repo ]]; then
  curl -ksS https://raw.githubusercontent.com/newren/git-filter-repo/main/git-filter-repo -o ~/.local/bin/git-filter-repo
fi

# Install Repo
if [[ ! -d ~/.local/git-repo ]]; then
  git clone https://gerrit.googlesource.com/git-repo "${HOME}"/.local/git-repo
fi

# Install RUST
if ! command -v rustup &> /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

echo "Please run source ~/.bashrc a few times to complete installation !"
