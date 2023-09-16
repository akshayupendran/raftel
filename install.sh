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
# APT Installations
declare -A g_apt_programs_dict
source install.conf
## Requires sudo
if command sudo -v; then
  sudo apt -yqq update
  sudo apt -yqq upgrade
  ### Useful scripts to add and remove PPA
  if ! command -v add-apt-repository &> /dev/null; then
    sudo apt -yqq inst:all software-properties-common
  fi
  ### Install list of apt programs
  for l_program in $g_apt_programs; do
    if ! command -v $l_program &> /dev/null; then
      sudo apt -yqq install $l_program
    fi
  done;
  unset l_program;
  ### Install second list of apt programs
  for l_program in "${!g_apt_programs_dict[@]}"; do
    if ! command -v ${g_apt_programs_dict[$l_program]} &> /dev/null; then
      sudo apt -yqq install $l_program
    fi
  done;
  unset l_program;
  sudo -k  
fi

# Dotfiles stowing - requires stow
if command -v stow &> /dev/null; then
  ## Dirty check via .path if path already exists. If exists dont install.
  if [[ ! -f ~/.path ]]; then
    mv -f ~/.bashrc ~/.bashrc.bak
    for l_folder in */ ; do\
      stow --dotfiles "$l_folder"
    done
    unset l_folder;
  fi
fi

for l_folder in ~/.{local,local/bin,config}; do
  if [[ ! -d $l_folder ]]; then
    mkdir $l_folder
  fi
done;
unset l_folder;

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

# Install rustc
if ! command -v rustc &> /dev/null; then
  curl --proto '=https' --tlsv1.2 -ksSf https://sh.rustup.rs -o temp.sh
  chmod +x temp.sh
  ./temp.sh -y
  rm -f temp.sh
fi

echo "Please run source ~/.bashrc a few times to complete installation !"
