vim9script

# Automatically cd to the project root corresponding to the current buffer.
# Project root is "marked" by specific directories or files.

var rootMarkers = {
  dirs: ['.git', '.hg', '.svn'],
  files: ['configure', 'Cargo.toml', 'go.mod', 'package.json', '.project.vim']
}

export def CurDir(): string
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

export def FindRootDirectory(): string
  var curdir = CurDir()

  if curdir->empty()
    return ''
  endif

  # :help 'path'
  curdir = curdir->escape(' ')

  var rootdir = ''
  for file in rootMarkers.files
    rootdir = findfile(file, $"{curdir};")
    if !rootdir->empty()
      return rootdir->fnamemodify(':h')
    endif
  endfor
  if rootdir->empty()
    for dir in rootMarkers.dirs
      rootdir = finddir(dir, $"{curdir};")
      if !rootdir->empty()
        return rootdir->fnamemodify(':h')
      endif
    endfor
  endif

  return ''
enddef

export def Rooter(cdcmd: string = 'lcd')
  if &buftype != '' && ['dir', 'fugitive']->index(&ft) == -1
    return
  endif

  const rootdir = FindRootDirectory()

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

