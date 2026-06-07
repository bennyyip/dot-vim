vim9script

import autoload '../autoload/rooter.vim'
import autoload '../autoload/async.vim'

command! -nargs=1 -complete=shellcmdline AsyncCmd async.Run(<q-args>, {'kind': 'echo', 'wall': true})
command! -nargs=1 -bang -complete=shellcmdline AsyncQf async.Run(<q-args>, {'kind': 'qf', 'wall': true, 'jump': !<bang>0})
command! -nargs=+ -bang -complete=shellcmdline AsyncSpawn async.Spawn(<f-args>)
command! -bang AsyncReRun async.ReRun(<bang>0)
command! -nargs=0 StopJobs async.StopJobs()
command! -nargs=0 AsyncToggleSound async.ToggleSound()

command! -nargs=+ -bang -complete=compiler Compiler async.Compiler({jump: !<bang>0}, <f-args>)
command! -nargs=+ -bang -complete=compiler QCompiler async.Compiler({jump: !<bang>0, copen: false}, <f-args>)
command! -nargs=+ -bang -complete=compiler LCompiler async.Compiler({jump: !<bang>0, local: true}, <f-args>)
command! -nargs=? -bang -complete=custom,async.MakeComplete Make async.Run(<q-args>, {'kind': 'make', 'wall': true, 'jump': <bang>0})

command! -bang -bar -nargs=? Gpush execute $'AsyncCmd git -C {fnameescape(g:FugitiveGitDir())} push' <q-args>
command! -bang -bar -nargs=? Gfetch execute $'AsyncCmd git -C {fnameescape(g:FugitiveGitDir())} fetch' <q-args>

command! -nargs=? -bang Rg async.Run((<q-args> == '' ? expand('<cword>') : <q-args>), {kind: 'grep', expand: <bang>0})
command! -nargs=? -bang Rgr rooter.Rooter()<BAR>Rg<bang> <args>

noremap <leader>: :StopJobs<CR>

def GrepVisual(): string
    var vtext = getregion(getpos('v'), getpos('.'), { type: mode() })->join("\n")
    return ($"\<ESC>:Rgr -F '{vtext}'")
enddef
nnoremap <leader>/ :Rgr<space>
nnoremap <leader>? :Rg<space>
xnoremap <expr> <leader>/ GrepVisual()


# Expand last search to all files with matching extension
nnoremap <localleader>/ :execute "Rg -t " .. &ft .. ' ' .. @/<CR>
# slower
nnoremap <localLeader>? :execute "vimgrep // **/*." . expand("%:e")<CR>

augroup vimrc
  autocmd filetype qf nnoremap <buffer> <F5> <cmd>AsyncReRun<CR>
augroup END

# TODO
# command! -nargs=* Locate async#qfix(<q-args>, {'grepformat': "%f", "grepprg": "locate", "grep": 1})

