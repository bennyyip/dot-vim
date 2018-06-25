let g:tex_conceal=0
nnoremap <buffer><leader>R :w<CR>:AsyncRun xelatex %<CR>
" ae and ie conflict with kana/vim-textobj-entire
omap <buffer>aE <plug>(vimtex-ae)
xmap <buffer>aE <plug>(vimtex-ae)
omap <buffer>iE <plug>(vimtex-ie)
xmap <buffer>iE <plug>(vimtex-ie)

autocmd FileType tex let b:lexima_disabled = 1
setlocal colorcolumn=100
setlocal textwidth=100


let g:sleuth_automatic = 0
