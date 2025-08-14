vim9script

var rootMarkers = {
  dirs: ['.git', '.hg', '.svn', '.project.vim'],
  files: ['configure', 'Cargo.toml', 'mix.exs', 'go.mod', 'package.json']
}

def g:FindRootDirectory(): string
  var rootDir = ''
  if &buftype != ''
    return ''
  endif

  if !isdirectory(expand("%:h"))
    return ''
  endif

  for dir in rootMarkers.dirs
    rootDir = finddir(dir, expand("%:p:h") .. ";")
    if !rootDir->empty()
      break
    endif
  endfor
  if rootDir->empty()
    for file in rootMarkers.files
      rootDir = findfile(file, expand("%:p:h") .. ";")
      if !rootDir->empty()
        break
      endif
    endfor
  endif

  if !rootDir->empty()
    return fnamemodify(rootDir, ":h:p")
  else
    return ''
  endif
enddef

def g:SetProjectRoot()
  const rootDir = g:FindRootDirectory()
  if !rootDir->empty()
    exe "lcd " .. rootDir
  endif
enddef

nmap <silent> <leader>r <cmd>call g:SetProjectRoot()<bar>pwd<CR>

# augroup prjroot | au!
#   au BufEnter * g:SetProjectRoot()
# augroup END
