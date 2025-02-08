vim9script

def Root(): string
  var dir = getbufvar('%', 'projectRoot')
  if !empty(dir)
    return dir
  endif

  const buf = '%'
  dir = expand('%:p:h', 1)
  dir = dir->substitute("^dir://", "", "")
  dir = resolve(dir)
  var prev = ''

  while true
    const projectvimrc = $'{dir}/.project.vim'
    if filereadable(projectvimrc)
      return dir
    endif

    prev = dir
    dir = fnamemodify(dir, ':h')
    if prev == dir
      break
    endif
  endwhile

  setbufvar('%', 'projectRoot', dir)
  return dir
enddef

def SourceProjectVimrc()
  if getbufvar('%', 'sourcedProjectVimrc', false)
    return
  endif
  defer setbufvar('%', 'sourcedProjectVimrc', true)

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

g:Harpoon('v', '~/.vim', 4)
