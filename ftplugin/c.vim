setlocal commentstring=//\ %s
if &filetype ==# "cpp"
  nnoremap <silent> <F9> :AsyncRun -save=1 g++ -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <CR>
else
  nnoremap <silent> <F9> :AsyncRun -save=1 gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <CR>
endif
nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <CR>

imap <c-l> <Plug>CompletorCppJumpToPlaceholder 
