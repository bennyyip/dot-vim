vim9script
import autoload 'rooter.vim'

def Root(): string
  var dir = getbufvar('%', 'projectRoot')
  if !empty(dir)
    return dir
  endif

  const curdir = rooter.CurDir()
  if curdir->empty()
    return ''
  endif

  var rootdir = findfile('.project.vim', curdir .. ';')
  if !rootdir->empty()
    rootdir = rootdir->fnamemodify(':h')
    setbufvar('%', 'projectRoot', rootdir)
    return rootdir
  else
    return ''
  endif
enddef

def SourceProjectVimrc()
  defer setbufvar('%', 'sourcedProjectVimrc', true)
  if getbufvar('%', 'sourcedProjectVimrc', false)
    return
  endif

  const root = Root()
  if empty(root)
    return
  endif

  const projectvimrc = root .. '/.project.vim'
  if filereadable(projectvimrc)
    execute $'source {projectvimrc}'
  endif
enddef

# Inspired by https://github.com/ThePrimeagen/harpoon
def g:Harpoon(mark: string, path: string, row: number = 1, col: number = 1)
  const m = $"'{mark->toupper()}"
  var p = expand(path)
  p = isabsolutepath(p) ? p : $"{Root()}/{p}"
  const b = bufnr(p, true)
  setpos(m, [b, row, col, 0])
enddef

augroup Project
  autocmd!
  autocmd BufReadPost,BufEnter * SourceProjectVimrc()
augroup END

g:Harpoon('V', "$MYVIMDIR")
g:Harpoon('D', '~/dotfiles')
g:Harpoon('Z', '~/dotfiles/zsh/.zshrc')
