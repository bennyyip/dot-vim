if !hasmapto('<Plug>NetrwBrowseX')
  nmap <unique> gX <Plug>NetrwBrowseX
endif
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))<cr>


