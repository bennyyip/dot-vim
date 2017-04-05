au filetype tex nnoremap <leader>R :w<CR>:AsyncRun xelatex %<CR>
let g:tex_conceal=0
" ae and ie conflict with kana/vim-textobj-entire
au filetype tex omap aE <plug>(vimtex-ae)
au filetype tex xmap aE <plug>(vimtex-ae)
au filetype tex omap iE <plug>(vimtex-ie)
au filetype tex xmap iE <plug>(vimtex-ie)

autocmd FileType tex let b:lexima_disabled = 1
