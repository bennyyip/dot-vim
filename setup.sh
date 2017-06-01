#!/bin/bash

pacaur -S universal-ctags-git powerline-fonts ripgrep-broadwell-git ttf-inziu-iosevka yapf --needed

vim +PlugInstall +qall
