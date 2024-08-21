vim9script
# Plugin: dyng/ctrlsf.vim

g:ctrlsf_default_root = 'project+fw'
g:ctrlsf_populate_qflist = 1

nmap     <leader>sf <Plug>CtrlSFPrompt
nmap     <leader>s* <Plug>CtrlSFCwordExec
vmap     <leader>sF <Plug>CtrlSFVwordPath
vmap     <leader>sf <Plug>CtrlSFVwordExec
nmap     <leader>sP <Plug>CtrlSFPwordPath
nmap     <leader>sp <Plug>CtrlSFPwordExec
nnoremap <leader>so :CtrlSFToggle<CR>
