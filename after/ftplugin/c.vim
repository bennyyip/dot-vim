setlocal commentstring=//\ %s

if Plugpac#HasPlugin("asyncrun.vim")
  if &filetype ==# "cpp"
    nnoremap <buffer><silent> <F9> :AsyncRun -save=1 g++ -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <CR>
  else
    nnoremap <buffer><silent> <F9> :AsyncRun -save=1 gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <CR>
  endif
  nnoremap <buffer><silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <CR>
endif

if plugpac#HasPlugin("completor")
  imap <buffer><c-l> <Plug>CompletorCppJumpToPlaceholder
endif
