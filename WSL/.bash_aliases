#!/usr/bin/env bash

## Author Akshay Krishna Upendran

# User Modified configurations
alias dl="cd /mnt/c/Users/akrish10/Downloads"
alias dt="cd '/mnt/c/Users/akrish10/OneDrive - Visteon/Desktop'"
alias p="cd ~/wsl-setup"

# Shortcuts
alias g="git"

# Pass aliases to sudo commands: https://stackoverflow.com/questions/37209913/how-does-alias-sudo-sudo-work
#alias sudo='sudo '

# Useful commands
alias week='date +%V'
alias update='sudo apt update; sudo apt -y upgrade'
alias hd="hexdump -C"
alias map="xargs -n1"
alias path='echo -e ${PATH//:/\\n}'

# Always use python3
alias python=python3

# Always use podman
alias docker=podman
