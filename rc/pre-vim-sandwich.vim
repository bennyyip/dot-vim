vim9script
g:sandwich_no_default_key_mappings = 1
g:operator_sandwich_no_default_key_mappings = 1
g:textobj_sandwich_no_default_key_mappings = 1
nmap ys <Plug>(sandwich-add)
onoremap <SID>line :normal! ^vg_<CR>
nmap <silent> yss <Plug>(sandwich-add)<SID>line
nmap ds <Plug>(sandwich-delete)
nmap dss <Plug>(sandwich-delete-auto)
nmap cs <Plug>(sandwich-replace)
nmap css <Plug>(sandwich-replace-auto)
xmap S <Plug>(sandwich-add)

