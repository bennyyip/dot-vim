setlocal tabstop=4 softtabstop=4 shiftwidth=4

if plugpac#HasPlugin("asyncrun.vim")
  nnoremap <buffer><F5>      :AsyncRun -raw python %<CR>
  inoremap <buffer><F5> <ESC>:AsyncRun -raw python %<CR>
  xnoremap <buffer><F5>      :AsyncRun -raw python  <CR>
endif

