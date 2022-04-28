setl tabstop=4 shiftwidth=4 noexpandtab

nmap <buffer> <localleader>e <Plug>(go-iferr)
nmap <buffer> <localleader>i :GoImpl<space>

nmap <buffer> <f2> <Plug>(go-rename)
nmap <buffer> gr <Plug>(go-referrers)

" autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
