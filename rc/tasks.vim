vim9script

call extend(g:async_default_opts, {'openqf': 1, 'nojump': 1})

command! -nargs=1 -bang -complete=shellcmdline AsyncCmd call async#cmd(<q-args>, 'cmdline',  {'writelogs': <bang>0})
command! -nargs=1 -bang -complete=shellcmdline Async    call async#cmd(<q-args>, 'headless', {'writelogs': <bang>0})
command! -nargs=1 -bang -complete=shellcmdline AsyncQf  call async#cmd(<q-args>, 'quickfix', {'writelogs': <bang>0, 'nojump': 0, 'wall': 1})

def Escape(s: string): string
  return substitute(s, "[#]", '\\\0', 'g')
enddef

command! -nargs=1 -bang Rg call async#qfix(Escape(<q-args>), {'grep': 1})
command! -nargs=1 -bang Rgr {
  # const saved_cwd = getcwd()
  chdir(g:FindRootDirectory())
  async#qfix(Escape(<q-args>), {'grep': 1})
  # chdir(saved_cwd)
}

command! -nargs=* Locate async#qfix(<q-args>, {'grepformat': "%f", "grepprg": "locate", "grep": 1})

noremap <leader>; :AsyncCmd<space>
noremap <leader>: :StopJobs<CR>

command! -bang -bar -nargs=* Gpush  {
  execute $'AsyncCmd git -C {fnameescape(g:FugitiveGitDir())} push' <q-args>
}
command! -bang -bar -nargs=* Gfetch  {
  execute $'AsyncCmd git -C {fnameescape(g:FugitiveGitDir())} fetch' <q-args>
}

nnoremap <leader>/ :Rgr<space>
nnoremap <leader>? :Rg<space>
nnoremap <leader>F :Locate<space>

# Expand last search to all files with matching extension
nnoremap <localleader>/ :execute "Rg -t " .. &ft .. ' ' .. @/<CR>
# slower
nnoremap <localLeader>? :execute "vimgrep // **/*." . expand("%:e")<CR>

# repeat
nnoremap <localleader>q :AsyncQf<UP><CR>
