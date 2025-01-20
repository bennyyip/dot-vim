vim9script

call extend(g:async_default_opts, {'openqf': 1, 'nojump': 1})

command! -nargs=1 -bang -complete=file AsyncCmd call async#cmd(<q-args>, 'cmdline',  {'writelogs': <bang>0})
command! -nargs=1 -bang -complete=file Async    call async#cmd(<q-args>, 'headless', {'writelogs': <bang>0})
command! -nargs=1 -bang -complete=file AsyncQf  call async#cmd(<q-args>, 'quickfix', {'writelogs': <bang>0})

command! -nargs=1 -bang Rg call async#qfix(<q-args>, {'grep': 1})
command! -nargs=1 -bang Rgr {
  # const saved_cwd = getcwd()
  chdir(g:FindRootDirectory())
  async#qfix(<q-args>, {'grep': 1})
  # chdir(saved_cwd)
}
# Ripgrep word under cursor
nnoremap <leader>* <scriptcmd>exe "Rg" expand("<cword>")<cr>
xnoremap <leader>* "0y<scriptcmd>exe "Rg" getreg("0")<cr>

command! -nargs=* Locate async#qfix(<q-args>, {'errorformat': "%f", "makeprg": "locate"})

noremap <leader>; :AsyncCmd<space>
noremap <leader>: :StopJobs<CR>
cabbrev qf AsyncQf
cabbrev cm Compiler

command! -bang -bar -nargs=* Gpush  {
  execute $'AsyncCmd git -C {fnameescape(g:FugitiveGitDir())} push' <q-args>
}
command! -bang -bar -nargs=* Gfetch  {
  execute $'AsyncCmd git -C {fnameescape(g:FugitiveGitDir())} fetch' <q-args>
}

noremap <F5> :Async<UP><CR>
noremap <F8> :Compiler<UP><CR>

nnoremap <leader>/ :Rgr<space>
nnoremap <leader>sd :Rg<space>
nnoremap <leader>F :Locate<space>
