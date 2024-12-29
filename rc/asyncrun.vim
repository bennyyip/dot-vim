vim9script
# Plugin: skywind3000/asyncrun.vim

g:asyncrun_save = 1

augroup vimrc
  au User AsyncRunStop copen | wincmd p
  au User AsyncRunPre cclose
augroup END

command! -bang -nargs=* -complete=file -bar Make  AsyncRun<bang> -save=1 -program=make -auto=make @ <args>

command! -nargs=* Rg     call <SID>Rg(0, 0, <q-args>)
command! -nargs=* Rgr    call <SID>Rg(1, 0, <q-args>)
command! -nargs=* Rgadd  call <SID>Rg(0, 1, <q-args>)
command! -nargs=* Rgradd call <SID>Rg(1, 1, <q-args>)

command! -nargs=* Locate call <SID>Locate(<q-args>)

# vim-fugitive
command! -bang -bar -nargs=* Gpush execute 'AsyncRun<bang> -cwd=' .. fnameescape(g:FugitiveGitDir()) 'git push' <q-args>
command! -bang -bar -nargs=* Gfetch execute 'AsyncRun<bang> -cwd=' .. fnameescape(g:FugitiveGitDir()) 'git fetch' <q-args>

def Locate(args: string)
  g:ben_old_efm = &efm
  set efm=%f

  var cmd =  "AsyncRun! -post=let\\ &efm=g:ben_old_efm "

  const escaped_args = substitute(args, "[%#]", '\\\0', 'g')
  cmd ..= "@ locate " .. escaped_args
  execute cmd
enddef

def Rg(root: number, append: number, args: string)
  # avoid some plugin modify errorformat
  g:ben_old_efm = &efm
  set efm=%f:%\\s%#%l:%c:%m

  var cmd =  "AsyncRun! -post=let\\ &efm=g:ben_old_efm "

  var path = root == 0 ? expand('%:h:p') : asyncrun#get_root('%')

  if path == ""
    path = "."
  endif

  if append != 0
    cmd ..= "-append "
  endif

  const escaped_args = substitute(args, "[%#]", '\\\0', 'g')
  cmd ..= "@ rg --smart-case --vimgrep " .. escaped_args .. ' ' .. shellescape(path)
  execute cmd
enddef

noremap <leader>; :AsyncRun<space>
noremap <leader>: :AsyncStop<CR>
noremap <F5>      :AsyncRun<UP><CR>
noremap <F8>      :Make<CR>

nnoremap <leader>/ :Rgr<space>
nnoremap <leader>sd :Rg<space>
nnoremap <leader>F :Locate<space>

def MapPython()
  nnoremap <buffer><F6>      :AsyncRun -raw -mode=term -pos=thelp python %<CR>
  inoremap <buffer><F6> <ESC>:AsyncRun -raw -mode=term -pos=thelp python %<CR>
  xnoremap <buffer><F6>      :AsyncRun -raw python<CR>
enddef

augroup vimrc
  autocmd FileType python MapPython()
augroup END
