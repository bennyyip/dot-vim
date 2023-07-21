vim9script
# Plugin: dyng/ctrlsf.vim

g:ctrlsf_default_root = 'project'
g:ctrlsf_mapping = {
      \ 'next': 'n',
      \ 'prev': 'N',
      \ 'vsplit': 'x'
      \ }
g:ctrlsf_extra_backend_args = {
      \ 'rg': '--hidden'
      \ }

nmap     <leader>sf <Plug>CtrlSFPrompt
vmap     <leader>sf <Plug>CtrlSFVwordPath
vmap     <leader>sF <Plug>CtrlSFVwordExec
nmap     <leader>sn <Plug>CtrlSFCwordPath
nmap     <leader>sp <Plug>CtrlSFPwordPath
nnoremap <leader>so :CtrlSFOpen<CR>
nnoremap <leader>st :CtrlSFToggle<CR>
