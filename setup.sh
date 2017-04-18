#!/bin/bash
[ -f ~/.vim/autoload/plug.vim ] ||  \
  curl -fLo ~/.vim/autoload/plug.vim --create-dir \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
  echo "vim-plug installed"
[ -d ~/.vim/.swapfiles ] || mkdir ~/.vim/.swapfiles

#sudo pacman -Syyu ripgrep ttf-inziu-iosevka yapf --needed
pacaur -S universal-ctags-git powerline-fonts ripgrep-broadwell-git ttf-inziu-iosevka yapf --needed

vim +PlugInstall +qall
