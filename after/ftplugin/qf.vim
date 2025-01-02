nnoremap <silent> <buffer> H :call quickfixed#older()<CR>
nnoremap <silent> <buffer> L :call quickfixed#newer()<CR>
nnoremap <silent> <buffer> <Left> :call quickfixed#older()<CR>
nnoremap <silent> <buffer> <Right> :call quickfixed#newer()<CR>

noremap <buffer> <leader>q <cmd>cclose<CR>
