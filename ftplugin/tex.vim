let g:tex_conceal=0
nnoremap <leader>R :w<CR>:AsyncRun xelatex %<CR>
" ae and ie conflict with kana/vim-textobj-entire
omap aE <plug>(vimtex-ae)
xmap aE <plug>(vimtex-ae)
omap iE <plug>(vimtex-ie)
xmap iE <plug>(vimtex-ie)

autocmd FileType tex let b:lexima_disabled = 1
setlocal colorcolumn=100
setlocal textwidth=100
