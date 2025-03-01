" Vim plugin to change the working directory to the project root.
"
" Copyright 2010-2020 Andrew Stewart, <boss@airbladesoftware.com>
" Released under the MIT licence.

if exists('g:loaded_rooter') || &cp
  finish
endif
let g:loaded_rooter = 1

let s:nomodeline = (v:version > 703 || (v:version == 703 && has('patch442'))) ? '<nomodeline>' : ''

if !exists('g:rooter_manual_only')
  let g:rooter_manual_only = 0
endif

if exists('+autochdir') && &autochdir && !g:rooter_manual_only
  set noautochdir
endif

if exists('g:rooter_use_lcd')
  echoerr 'vim-rooter: please replace g:rooter_use_lcd=1 with g:rooter_cd_cmd="lcd"'
  let g:rooter_cd_cmd = 'lcd'
endif

if !exists('g:rooter_cd_cmd')
  let g:rooter_cd_cmd = 'cd'
endif

if !exists('g:rooter_buftypes')
  let g:rooter_buftypes = ['', 'nofile', 'nowrite', 'acwrite']
endif

if !exists('g:rooter_patterns')
  let g:rooter_patterns = ['.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json']
endif

if !exists('g:rooter_targets')
  let g:rooter_targets = ['/', '*']
endif

if !exists('g:rooter_change_directory_for_non_project_files')
  let g:rooter_change_directory_for_non_project_files = ''
endif

if !exists('g:rooter_silent_chdir')
  let g:rooter_silent_chdir = 0
endif

if !exists('g:rooter_resolve_links')
  let g:rooter_resolve_links = 0
endif

if !exists('g:rooter_ignore')
  let g:rooter_ignore = 0
endif


" For third-parties.  Not used by plugin.
function! FindRootDirectory()
  return s:root()
endfunction


command! -bar Rooter call <SID>rooter()
command! -bar RooterToggle call <SID>toggle()


augroup rooter
  autocmd!
  autocmd VimEnter,BufReadPost,BufEnter * nested if !g:rooter_manual_only | call <SID>rooter(+expand('<abuf>')) | endif
  autocmd BufWritePost * nested if !g:rooter_manual_only | call <SID>clear_cache(+expand('<abuf>')) | call <SID>rooter(+expand('<abuf>')) | endif
augroup END


function! s:rooter(...)
  if !s:activate() | return | endif

  let bufnr = a:0 ? a:1 : '%'

  let root = getbufvar(bufnr, 'rootDir')
  if empty(root)
    let root = s:root()
    call setbufvar(bufnr, 'rootDir', root)
  endif

  if empty(root)
    call s:rootless()
    return
  endif

  call s:cd(root)
endfunction


function! s:clear_cache(bufnr)
  call setbufvar(a:bufnr, 'rootDir', '')
endfunction


" Returns true if we should change to the buffer's root directory, false otherwise.
function! s:activate()
  if index(g:rooter_buftypes, &buftype) == -1 | return 0 | endif

  if type(g:rooter_targets) == type([])
    let patterns = g:rooter_targets
  else
    let patterns = split(g:rooter_targets, ',')
  endif
  let fn = s:current_file()

  " directory
  if empty(fn) || isdirectory(fn)
    return index(patterns, '/') != -1
  endif

  " file
  if !filereadable(fn) | return 0 | endif
  if !exists('*glob2regpat') | return 1 | endif

  for p in filter(copy(patterns), 'v:val != "/"')
    if p[0] == '!'
      let [p, verdict] = [p[1:], 0]
    else
      let [p, verdict] = [p, 1]
    endif
    if fn =~ glob2regpat(p)
      return verdict
    endif
  endfor

  return 0
endfunction


" Returns the root directory or an empty string if no root directory found.
function! s:root()
  let dir = s:current()

  let patterns = g:rooter_ignore
        \      ? s:remove_ignored(g:rooter_patterns, dir, s:current_file())
        \      : g:rooter_patterns

  " breadth-first search
  while 1
    for pattern in patterns
      if pattern[0] == '!'
        let [p, exclude] = [pattern[1:], 1]
      else
        let [p, exclude] = [pattern, 0]
      endif
      if s:match(dir, p)
        if exclude
          break
        else
          return dir
        endif
      endif
    endfor

    let [current, dir] = [dir, s:parent(dir)]
    if current == dir | break | endif
  endwhile

  return ''
endfunction


function! s:remove_ignored(patterns, dir, file)
  let unignored_patterns = []
  for pattern in a:patterns
    if pattern == '.git'
      call system('git -C ' .. shellescape(a:dir) .. ' check-ignore -q -- ' .. shellescape(a:file))
      let ignored = !v:shell_error
      if ignored
        continue
      endif
    endif
    call add(unignored_patterns, pattern)
  endfor
  return unignored_patterns
endfunction


function s:match(dir, pattern)
  if a:pattern[0] == '='
    return s:is(a:dir, a:pattern[1:])
  elseif a:pattern[0] == '^'
    return s:sub(a:dir, a:pattern[1:])
  elseif a:pattern[0] == '>'
    return s:child(a:dir, a:pattern[1:])
  else
    return s:has(a:dir, a:pattern)
  endif
endfunction


" Returns true if dir is identifier, false otherwise.
"
" dir        - full path to a directory
" identifier - a directory name
function! s:is(dir, identifier)
  let identifier = substitute(a:identifier, '/$', '', '')
  return fnamemodify(a:dir, ':t') ==# identifier
endfunction


" Returns true if dir contains identifier, false otherwise.
"
" dir        - full path to a directory
" identifier - a file name or a directory name; may be a glob
function! s:has(dir, identifier)
  " We do not want a:dir to be treated as a glob so escape any wildcards.
  " If this approach is problematic (e.g. on Windows), an alternative
  " might be to change directory to a:dir, call globpath() with just
  " a:identifier, then restore the working directory.
  return !empty(globpath(escape(a:dir, '?*[]'), a:identifier, 1))
endfunction


" Returns true if identifier is an ancestor of dir,
" i.e. dir is a subdirectory (no matter how many levels) of identifier;
" false otherwise.
"
" dir        - full path to a directory
" identifier - a directory name
function! s:sub(dir, identifier)
  let path = s:parent(a:dir)
  while 1
    if fnamemodify(path, ':t') ==# a:identifier | return 1 | endif
    let [current, path] = [path, s:parent(path)]
    if current == path | break | endif
  endwhile
  return 0
endfunction

" Return true if identifier is a direct ancestor (parent) of dir,
" i.e. dir is a direct subdirectory (child) of identifier; false otherwise
"
" dir        - full path to a directory
" identifier - a directory name
function! s:child(dir, identifier)
  let path = s:parent(a:dir)
  return fnamemodify(path, ':t') ==# a:identifier
endfunction

" Returns full path of directory of current file name (which may be a directory).
function! s:current()
  let fn = s:current_file()
  if empty(fn) | return getcwd() | endif  " opening vim without a file
  return fnamemodify(fn, ':h')
endfunction

" Returns full path of current file name
function s:current_file()
  let fn = expand('%:p', 1)
  let fn = fn->substitute("^dir://", "", "")
  if fn =~ 'NERD_tree_\d\+$' | let fn = b:NERDTree.root.path.str().'/' | endif
  if fn[:5] == 'oil://' | let fn = fn[5:] | endif
  if g:rooter_resolve_links | let fn = resolve(fn) | endif
  return fn
endfunction

" Returns full path of dir's parent directory.
function! s:parent(dir)
  return fnamemodify(a:dir, ':h')
endfunction


" Changes to the given directory unless it is already the current one.
function! s:cd(dir)
  if a:dir == getcwd() | return | endif
  execute g:rooter_cd_cmd fnameescape(a:dir)
  if !g:rooter_silent_chdir | redraw | echo 'cwd: '.a:dir | endif
  if exists('#User#RooterChDir')
    execute 'doautocmd' s:nomodeline 'User RooterChDir'
  endif
endfunction


function! s:rootless()
  let dir = ''
  if g:rooter_change_directory_for_non_project_files ==? 'current'
    let dir = s:current()
  elseif g:rooter_change_directory_for_non_project_files ==? 'home'
    let dir = $HOME
  endif
  if !empty(dir) | call s:cd(dir) | endif
endfunction


function! s:toggle()
  if g:rooter_manual_only | Rooter | endif
  let g:rooter_manual_only = !g:rooter_manual_only
endfunction


" vim:set ft=vim sw=2 sts=2 et:
