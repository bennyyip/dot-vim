vim9script
# Plugin: skywind3000/asyncrun.vim

g:asyncrun_save = 1

augroup vimrc
  au User AsyncRunStop copen | wincmd p
  au User AsyncRunPre cclose
augroup END

command! -bang -nargs=* -complete=file -bar Make  AsyncRun<bang> -save=1 -program=make -auto=make @ <args>

command! -bang -nargs=* Qrg     call <SID>Rg(0, 0, <q-args>)
command! -bang -nargs=* Qrgr    call <SID>Rg(1, 0, <q-args>)
command! -bang -nargs=* Qrgadd  call <SID>Rg(0, 1, <q-args>)
command! -bang -nargs=* Qrgradd call <SID>Rg(1, 1, <q-args>)

def Rg(root: number, append: number, args: string)
  # avoid some plugin modify errorformat
  g:ben_old_efm = &efm
  set efm=%f:%\\s%#%l:%c:%m

  var cmd =  "AsyncRun! -strip -post=let\\ &efm=g:ben_old_efm "

  var path = root == 0 ? expand('%:h:p') : asyncrun#get_root('%')

  if path == ""
    path = "."
  endif

  if append != 0
    cmd ..= "-append "
  endif

  # split args with '#'
  # TODO: escape
  var escaped_args = ""
  for x in args->split('#')
    escaped_args ..= " " .. fnameescape(x)
  endfor

  cmd ..= "@ rg --smart-case --vimgrep " .. escaped_args .. ' ' .. shellescape(path)
  execute cmd
enddef


noremap <leader>; :AsyncRun<space>
noremap <leader>: :AsyncStop<CR>
noremap <F8>      :Make<CR>

noremap <silent> <leader>q :<C-u>call asyncrun#quickfix_toggle(8)<CR>

nnoremap <leader>/ :Qrgr<space>
nnoremap <leader>sd :Qrg<space>

def MapPython()
  nnoremap <buffer><F5>      :AsyncRun -raw -mode=term -pos=thelp python %<CR>
  inoremap <buffer><F5> <ESC>:AsyncRun -raw -mode=term -pos=thelp python %<CR>
  xnoremap <buffer><F5>      :AsyncRun -raw python<CR>
enddef

augroup vimrc
  autocmd FileType python MapPython()
augroup END
