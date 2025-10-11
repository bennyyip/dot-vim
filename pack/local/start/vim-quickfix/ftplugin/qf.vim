vim9script

import autoload 'qf.vim'

nnoremap <buffer> o <scriptcmd>qf.View()<CR>
nnoremap <buffer> gq <scriptcmd>wincmd c<CR>
nnoremap <buffer> J <scriptcmd>qf.Next()<CR>
nnoremap <buffer> K <scriptcmd>qf.Prev()<CR>
nnoremap <silent> <buffer> {          <cmd>cNfile<CR>
nnoremap <silent> <buffer> }          <cmd>cnfile<CR>
nnoremap <silent> <buffer> [f         <scriptcmd>qf.Older()<CR>
nnoremap <silent> <buffer> ]f         <scriptcmd>qf.Newer()<CR>
nnoremap <silent> <buffer> H          <scriptcmd>qf.Older()<CR>
nnoremap <silent> <buffer> L          <scriptcmd>qf.Newer()<CR>
nnoremap <silent> <buffer> <C-G><C-G> <scriptcmd>qf.Print()<CR>

if qf.IsLocationList()
  command! -nargs=+ -buffer Keep   :Lfilter  <args>
  command! -nargs=+ -buffer Reject :Lfilter! <args>
else
  command! -nargs=+ -buffer Keep   :Cfilter  <args>
  command! -nargs=+ -buffer Reject :Cfilter! <args>
endif

# setlocal winfixbuf
