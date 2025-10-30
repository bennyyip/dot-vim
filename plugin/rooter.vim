vim9script

# Automatically cd to the project root corresponding to the current buffer.
# Project root is "marked" by specific directories or files.

var rootMarkers = {
  dirs: ['.git', '.hg', '.svn'],
  files: ['configure', 'Cargo.toml', 'go.mod', 'package.json', '.project.vim']
}

def CurDir(): string
  var curdir = expand("%:p")
    ->substitute('^dir://', '', '')
    ->substitute('^fugitive:[/\\]\{2}\(.*\)[/\\]\.git', '\1', '')

  # resolve symlink
  curdir = resolve(curdir)
  if !isdirectory(curdir)
    curdir = fnamemodify(curdir, ":h")
  endif

  if !isdirectory(curdir)
    return ''
  endif

  return curdir
enddef

def g:FindRootDirectory(): string
  var curdir = CurDir()
  if curdir->empty()
    return ''
  endif

  var rootdir = ''

  for dir in rootMarkers.dirs
    rootdir = finddir(dir, $"{curdir};")
    if !rootdir->empty()
      return rootdir->fnamemodify(':h')
    endif
  endfor
  if rootdir->empty()
    for file in rootMarkers.files
      rootdir = findfile(file, $"{curdir};")
      if !rootdir->empty()
        return rootdir->fnamemodify(':h')
      endif
    endfor
  endif

  return ''
enddef

def g:Rooter(cdcmd: string = 'lcd')
  if &buftype != '' && ['dir', 'fugitive']->index(&ft) == -1
    return
  endif

  const rootdir = g:FindRootDirectory()

  if !rootdir->empty()
    exe cdcmd .. ' ' rootdir
    # else
    # const curdir = CurDir()
    # if curdir->empty()
    #   return
    # endif
    # exe cdcmd .. " " .. curdir
  endif
enddef


augroup rooter | au!
  au BufEnter * g:Rooter()
augroup END

nmap <silent> <leader>r <scriptcmd>g:Rooter()<CR>
