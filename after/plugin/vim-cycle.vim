" Plugin: bootleq/vim-cycle
if !plugpac#has_plugin('vim-cycle')
  finish
endif

nnoremap <expr> <silent> <C-X> ben#trycycle('x')
vnoremap <expr> <silent> <C-X> ben#trycycle('x')
nnoremap <expr> <silent> <C-A> ben#trycycle('p')
vnoremap <expr> <silent> <C-A> ben#trycycle('p')
nnoremap <Plug>CycleFallbackNext <C-A>
nnoremap <Plug>CycleFallbackPrev <C-X>
