" Plugin: dyng/ctrlsf.vim
if !ben#has_plugin('ctrlsf.vim')
  finish
endif

nmap     <leader>sf <Plug>CtrlSFPrompt
vmap     <leader>sf <Plug>CtrlSFVwordPath
nmap     <leader>sn <Plug>CtrlSFCwordPath
nmap     <leader>sp <Plug>CtrlSFPwordPath
nnoremap <leader>so :CtrlSFOpen<CR>
nnoremap <leader>st :CtrlSFToggle<CR>
