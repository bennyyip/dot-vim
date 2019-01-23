" Plugin: Yggdroot/LeaderF
if !plugpac#has_plugin('LeaderF')
  finish
endif

nnoremap <leader>fr :LeaderfMru<CR>
nnoremap <leader>gt :LeaderfBufTag<CR>
nnoremap <leader>b  :LeaderfBuffer<CR>

if plugpac#has_plugin('LeaderF-github-stars')
  nnoremap <leader>gs :LeaderfStars<CR>
endif

if plugpac#has_plugin('LeaderF-ghq')
  nnoremap <leader>gr :LeaderfGhq<CR>
endif
