if (-Not (Test-Path .swapfiles)) {
  New-Item -ItemType Directory .swapfiles
}

Copy-Item winvimrc ~/.vimrc

vim +PlugInstall +qall