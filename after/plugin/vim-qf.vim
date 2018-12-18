" Plugin: romainl/vim-qf
if !ben#has_plugin('vim-qf')
  finish
endif

nmap <leader>q <Plug>(qf_qf_toggle_stay)
nmap <leader>l <Plug>(qf_loc_toggle_stay)
