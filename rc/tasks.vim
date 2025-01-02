vim9script

call extend(g:async_default_opts, {'openqf': 1, 'nojump': 1})

cabbrev cm Compiler
cabbrev asb AsyncBuf

command! -nargs=1 -bang Rg call async#qfix(<q-args>, {'grep': 1})
command! -nargs=1 -bang Rgr {
  # const saved_cwd = getcwd()
  chdir(g:FindRootDirectory())
  async#qfix(<q-args>, {'grep': 1})
  # chdir(saved_cwd)
}
command! -nargs=* Locate async#qfix(<q-args>, {'errorformat': "%f", "makeprg": "locate"})

nnoremap <leader>q <cmd>copen<CR>

noremap <leader>; :AsyncCmd<space>
noremap <leader>: :StopJobs<CR>


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
