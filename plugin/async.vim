vim9script

import autoload '../autoload/rooter.vim'
import autoload '../autoload/async.vim'

command! -nargs=1 -complete=shellcmdline AsyncCmd call async.Run(<q-args>, {'kind': 'echo', 'wall': true})
command! -nargs=1 -bang -complete=shellcmdline AsyncQf call async.Run(<q-args>, {'kind': 'qf', 'wall': true, 'jump': <bang>0})
command! -nargs=+ -bang -complete=shellcmdline AsyncSpawn call async.Spawn(<f-args>)
command! -nargs=+ -bang -complete=compiler Compiler call Compiler(<bang>0, <f-args>)
command! -nargs=? -bang Make  call async.Run(<q-args>, {'kind': 'make', 'wall': true, 'jump': <bang>0})

command! -bang -bar -nargs=? Gpush  {
  execute $'AsyncCmd git -C {fnameescape(g:FugitiveGitDir())} push' <q-args>
}
command! -bang -bar -nargs=? Gfetch  {
  execute $'AsyncCmd git -C {fnameescape(g:FugitiveGitDir())} fetch' <q-args>
}

command! -nargs=1 -bang Rg call async.Run(<q-args>, {kind: 'grep', expand: <bang>0})
command! -nargs=1 -bang Rgr call chdir(rooter.FindRootDirectory(), 'window')<BAR>Rg<bang> <args>

command! -nargs=0 StopJobs call async.StopJobs()

noremap <leader>: :StopJobs<CR>
nnoremap <leader>/ :Rgr<space>
nnoremap <leader>? :Rg<space>

# Expand last search to all files with matching extension
nnoremap <localleader>/ :execute "Rg -t " .. &ft .. ' ' .. @/<CR>
# slower
nnoremap <localLeader>? :execute "vimgrep // **/*." . expand("%:e")<CR>

# repeat
nnoremap <localleader>q :AsyncQf<UP><CR>

# TODO
# command! -nargs=* Locate async#qfix(<q-args>, {'grepformat': "%f", "grepprg": "locate", "grep": 1})
