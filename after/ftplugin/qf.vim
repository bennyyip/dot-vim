nnoremap <silent> <buffer> H          :call quickfixed#older()<CR>
nnoremap <silent> <buffer> L          :call quickfixed#newer()<CR>
nnoremap <silent> <buffer> <C-G><C-G> :call quickfixed#print()<CR>
nnoremap <silent> <buffer> <Left>     :call quickfixed#older()<CR>
nnoremap <silent> <buffer> <Right>    :call quickfixed#newer()<CR>
nnoremap <silent> <buffer> {          :cNfile<CR>
nnoremap <silent> <buffer> }          :cnfile<CR>

command! -nargs=+ -buffer Keep   :Cfilter  <args>
command! -nargs=+ -buffer Reject :Cfilter! <args>
