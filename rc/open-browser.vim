let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gX <Plug>(openbrowser-smart-search)
vmap gX <Plug>(openbrowser-smart-search)

" " gx
" nmap gX <Plug>NetrwBrowseX
" nno <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))<cr>
" xmap gX <Plug>NetrwBrowseXVis
" xno <silent> <Plug>NetrwBrowseXVis :<c-u>call netrw#BrowseXVis()<cr>
"
