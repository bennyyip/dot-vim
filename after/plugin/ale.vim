" Plugin: w0rp/ale
if !plugpac#has_plugin('ale')
  finish
endif

" override ]s [s
nmap <silent> ]s <Plug>(ale_next_wrap)
nmap <silent> [s <Plug>(ale_previous_wrap)
nmap <silent> <leader>= <Plug>(ale_fix)
nmap <silent> <leader>+ <Plug>(ale_enable_buffer)
