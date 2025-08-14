vim9script
import autoload 'scope/fuzzy.vim'
import autoload 'scope/popup.vim' as sp

sp.OptionsSet({emacsKeys: true})
sp.OptionsSet({borderhighlight: ['Identifier']})

def Fd(dir: string = "")
  if executable("fd")
    fuzzy.File($'fd . --path-separator / --type f --hidden --follow --exclude .git {dir}')
  elseif executable("fdfind")
    fuzzy.File($'fdfind . --path-separator / --type f --hidden --follow --exclude .git {dir}')
  elseif executable("rg")
    fuzzy.File($'rg --path-separator / --files --hidden --glob !.git {dir}')
  else
    fuzzy.File(fuzzy.FindCmd(dir))
  endif
enddef

command -nargs=1 -complete=dir ScopeGrep fuzzy.Grep('rg --vimgrep', true, null_string, <f-args>)
command -nargs=1 -complete=dir ScopeFile Fd(<f-args>)

def DirOfBuf(): string
  return &ft == 'dir' ? expand('%:.')->substitute("^dir://", "", "") : expand('%:.:h')
enddef

def SearchProject()
  const root = g:FindRootDirectory()
  if root == ''
    Fd(DirOfBuf())
  else
    Fd(root)
  endif
enddef

nnoremap <leader>ff <scriptcmd>SearchProject()<cr>
nnoremap <leader>fF <scriptcmd>Fd()<cr>
nnoremap <leader>. <scriptcmd>Fd(DirOfBuf())<cr>
nnoremap <leader>fp <scriptcmd>Fd(expand("$v"))<cr>

# noremap <leader>fr <scriptcmd>fuzzy.MRU()<cr>
nnoremap <leader>b <scriptcmd>fuzzy.Buffer(v:none, false)<cr>

command! History fuzzy.CmdHistory()
nnoremap <Plug>(meta-x) <scriptcmd>fuzzy.CmdHistory()<cr>
