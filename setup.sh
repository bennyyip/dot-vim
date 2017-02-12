#!/bin/bash

[ -d ~/.vim/.swapfiles ] || mkdir ~/.vim/.swapfiles

#sudo pacman -Syyu ripgrep ttf-inziu-iosevka yapf --needed
pacaur -S ripgrep-broadwell-git ttf-inziu-iosevka yapf --needed

vim +PlugInstall +qall
