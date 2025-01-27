vim9script

import autoload 'os.vim'

var pack_jobs = []


# Open current line/selection in Github.
# Usage:
#   import autoload 'git.vim'
#   nnoremap <silent> <space>gh <scriptcmd>git.GithubOpen()<CR>
#   xnoremap <silent> <space>gh <scriptcmd>git.GithubOpen(line("v"), line("."))<CR>
export def GithubOpen(firstline: number = line("."), lastline: number = line("."))
    const gitpath = fnameescape(g:FugitiveGitDir() .. '/../')
    var gitroot = systemlist($"git -C {gitpath} rev-parse --show-toplevel")->join('')
    var filename = strpart(expand('%:p'), len(gitroot) + 1)->tr('\', '/')
    var branch = systemlist($"git -C {gitpath} rev-parse --abbrev-ref HEAD")->join('')
    var remote_url = systemlist($"git -C {gitpath} remote get-url origin")->join('')
    if remote_url =~ '^git@github.com'
        remote_url = remote_url->substitute('^git@github.com:', 'https://github.com/', '')
    endif
    remote_url = remote_url->substitute('.git$', '', '')
    var github_url = $'{remote_url}/blob/{branch}/{filename}#L{firstline}-L{lastline}'
    os.Open(github_url)
enddef

