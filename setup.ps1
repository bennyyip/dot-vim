New-Item -ItemType Directory ~/.vim/autoload
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile($uri, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("~\.vim\autoload\plug.vim"))

if (-Not (Test-Path .swapfiles)) {
  New-Item -ItemType Directory .swapfiles
}

Copy-Item winvimrc ~/.vimrc

vim +PlugInstall +qall