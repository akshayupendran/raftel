#!/bin/bash
set -e
if [ -f "${HOME}.bashrc" ]; then
	cp -f "${HOME}.bashrc" "${HOME}.bashrc.bak"
fi
cp -RT dotfiles/ ~/

