if plugpac#has_plugin("asyncrun.vim")
  nnoremap <buffer><F5> :w<CR>:AsyncRun xelatex %<CR>
endif

" ae and ie conflict with kana/vim-textobj-entire
omap <buffer>aE <plug>(vimtex-ae)
xmap <buffer>aE <plug>(vimtex-ae)
omap <buffer>iE <plug>(vimtex-ie)
xmap <buffer>iE <plug>(vimtex-ie)

setlocal colorcolumn=100
setlocal textwidth=100
