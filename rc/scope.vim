vim9script
import autoload 'scope/fuzzy.vim'
import autoload 'scope/popup.vim' as sp

cabbrev sc Scope

sp.OptionsSet({emacsKeys: true})
sp.OptionsSet({borderhighlight: ['Identifier']})

def Fd(dir: string = "")
  fuzzy.File($'fd --hidden -tf --follow . {dir}')
enddef

command -nargs=1 -complete=dir ScopeGrep fuzzy.Grep('rg --vimgrep', true, null_string, <f-args>)
command -nargs=1 -complete=dir ScopeFile Fd(<f-args>)

def SearchProject()
  const root = g:FindRootDirectory()
  if root == ''
    Fd(expand('%:.:h'))
  else
    Fd(root)
  endif
enddef

nnoremap <leader>ff <scriptcmd>SearchProject()<cr>
nnoremap <leader>fF <scriptcmd>Fd()<cr>
nnoremap <leader>. <scriptcmd>Fd(expand('%:.:h'))<cr>
nnoremap <leader>fp <scriptcmd>Fd(expand("$v"))<cr>

# noremap <leader>fr <scriptcmd>fuzzy.MRU()<cr>
nnoremap <leader>b <scriptcmd>fuzzy.Buffer(v:none, false)<cr>

command! History fuzzy.CmdHistory()
nnoremap <Plug>(meta-x) <scriptcmd>fuzzy.CmdHistory()<cr>

