vim9script
# Plugin: romainl/vim-qf
# g:qf_mapping_ack_style = 0
g:qf_auto_open_quickfix = 0
g:qf_auto_open_loclist = 0
g:qf_auto_quit = 0

def QfMappings()
  nmap <buffer> { <Plug>(qf_previous_file)
  nmap <buffer> } <Plug>(qf_next_file)
enddef

augroup vimrc
  autocmd FileType qf QfMappings()
augroup END

nmap <leader>q <Plug>(qf_qf_toggle_stay)
nmap <leader>Q <Plug>(qf_qf_toggle)

# nmap <leader>l <Plug>(qf_loc_toggle_stay)
# nmap <leader>L <Plug>(qf_loc_toggle)
