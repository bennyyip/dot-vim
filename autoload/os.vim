vim9script

import autoload "dist/vim9.vim"

const istmux = !(empty($TMUX))
const iszellij = !(empty($ZELLIJ))

var shell = &shell
var shellslash = &shellslash
var shellcmdflag = &shellcmdflag

export def Sep(escape: bool = false): string
  if escape
    return has("win32") ? '\\' : '/'
  else
    return has("win32") ? '\' : '/'
  endif
enddef

# Return true if vim is in WSL environment
export def IsWsl(): bool
  return exists("$WSLENV")
enddef

export def ForceCmdexe()
  if !executable("cmd.exe")
    return
  endif

  if &shell !~? "cmd" || &shellslash
    shell = &shell
    shellslash = &shellslash
    shellcmdflag = &shellcmdflag

    &shell = $COMSPEC
    set noshellslash shellcmdflag=/c
  endif
enddef

export def RestoreShell()
  if !executable("cmd.exe")
    return
  endif
  &shell = shell
  &shellslash = shellslash
  &shellcmdflag = shellcmdflag
enddef

# Return Windows path from WSL
export def WslToWindowsPath(path: string): string
  if !IsWsl()
    return path
  endif

  if !executable('wslpath')
    return path
  endif

  var res = systemlist($"wslpath -w '{path}'")
  return empty(res) ? path : res[0]
enddef

# Open explorer/nautilus/dolphin with current file selected (if possible).
export def FileManager()
  if executable("cmd.exe")
    ForceCmdexe()
    defer RestoreShell()
  endif

  var path = ''
  if expand("%:p") == ""
    path = expand("%:p:h")
  else
    path = expand("%:p")
  endif
  path = substitute(path, "^dir://", "", "")
  var select = isdirectory(path) ? "" : "--select"

  if executable("cmd.exe")
    var job_opts = {}
    if IsWsl()
      path = escape(WslToWindowsPath(path), '\')
      job_opts.cwd = "/mnt/c"
    endif
    if executable('yazi')
      job_start(['wt.exe', 'yazi', path])
    else
      job_start('cmd.exe /c start "" explorer.exe /select,' .. path, job_opts)
    endif
  elseif istmux && executable("yazi")
    job_start(["tmux", "split-window", "-v", "yazi", path])
  elseif iszellij
    job_start(['zellij', 'run', '-c', '--', $SHELL, '-i', '-c', $"y {path}; exec $SHELL"])
  elseif executable("dolphin")
    system($'dolphin {select} {path} &')
  elseif executable("nautilus")
    job_start($'nautilus {select} {path}')
  else
    echomsg "Not yet implemented!"
  endif
enddef

# Open terminal/tmux in current file path
export def Terminal()
  var path = ""
  if expand("%:p") == ""
    path = expand("%:p:h")
  else
    path = expand("%:p")
  endif
  path = substitute(path, "^dir://", "", "")
  if !isdirectory(path)
    path = expand("%:p:h")
  endif

  if executable("wt.exe")
    job_start(['wt.exe', '-d', path], { cwd: path })
  elseif istmux
    job_start(["tmux", "split-window", "-h", "-c", path])
  elseif iszellij
    job_start(['zellij', 'action', 'new-pane', '-c', '--cwd', path, '--', $SHELL])
  endif
enddef

# Open filename in an OS
export def Open(url: string)
  echom url
  if $SSH_CONNECTION != ""
    silent! g:OSCYank(url)
    return
  endif

  if executable("cmd.exe")
    ForceCmdexe()
    defer RestoreShell()
  endif
  vim9.Open(url)
enddef


# Better gx to open URLs. https://ya.ru
# nnoremap <silent> gx :call os#Gx()<CR>
export def Gx()

  # URL regexes
  var rx_base = '\%(\%(http\|ftp\|irc\)s\?\|file\)://\S'
  var rx_bare = rx_base .. '\+'
  var rx_embd = rx_base .. '\{-}'

  var URL = ""

  var save_view = winsaveview()
  defer winrestview(save_view)

  # markdown URL [link text](http://ya.ru 'yandex search')
  if searchpair('\[.\{-}\](', '', ')\zs', 'cbW', '', line('.')) > 0
    URL = matchstr(getline('.')[col('.') - 1 : ], '\[.\{-}\](\zs' .. rx_embd .. '\ze\(\s\+.\{-}\)\?)')
  endif

  # asciidoc URL http://yandex.ru[yandex search]
  if empty(URL)
    if searchpair(rx_bare .. '\[', '', '\]\zs', 'cbW', '', line('.')) > 0
      URL = matchstr(getline('.')[col('.') - 1 : ], '\S\{-}\ze[')
    endif
  endif

  # HTML URL <a href='http://www.python.org'>Python is here</a>
  #          <a href="http://www.python.org"/>
  if empty(URL)
    if searchpair('<a\s\+href=', '', '\%(</a>\|/>\)\zs', 'cbW', '', line('.')) > 0
      URL = matchstr(getline('.')[col('.') - 1 : ],
        'href=["' .. "'" .. ']\?\zs\S\{-}\ze["' .. "'" .. ']\?/\?>')
    endif
  endif

  # URL <http://google.com>
  if empty(URL)
    URL = matchstr(expand("<cWORD>"), $'^<\zs{rx_bare}\ze>$')
  endif

  # URL (http://google.com)
  if empty(URL)
    URL = matchstr(expand("<cWORD>"), $'^(\zs{rx_bare}\ze)$')
  endif

  # barebone URL http://google.com
  if empty(URL)
    URL = matchstr(expand("<cWORD>"), rx_bare)
  endif

  if empty(URL)
    return
  endif


  Open(URL)
  # endif
enddef

export def Yank(s: string)
  if $SSH_CONNECTION != ""
    silent! g:OSCYank(s)
  else
    setreg('+', s)
  endif
enddef

export def Delete(bang: bool)
  if !bang && !(line('$') == 1 && empty(getline(1)) || getftype(expand('%')) !=# 'file')
    echoerr "File not empty (add ! to override)"
    return
  endif

  try
    const oldbuf = bufnr()
    delete(expand('%'))
    execute($"bdelete {oldbuf}")
  catch
    echohl ErrorMsg
    echom v:exception
    echohl None
  endtry
enddef

export def RenameInteractive(rename_to: string)
  var name = expand('%')
  var old_dir = expand("%:h")
  var old_name = expand("%:t")
  var new_name = rename_to
  if new_name == ''
    new_name = input($'Rename "{old_name}" to: ', old_name, "file")
  endif
  if empty(new_name) | return | endif
  if new_name == old_name | return | endif

  if !isabsolutepath(new_name)
    new_name = simplify($'{old_dir}{Sep()}{new_name}')
  endif
  if isdirectory(new_name) || filereadable(new_name)
    echohl ErrorMsg
    echo "Can't rename to existing file or directory!"
    echohl None
    return
  endif

  try
    mkdir(fnamemodify(new_name, ':h'), 'p')
    rename(name, new_name)
    const oldbuf = bufnr()
    execute($"edit {new_name}")
    execute($"bdelete {oldbuf}")
  catch
    echohl ErrorMsg
    echom v:exception
    echohl None
  endtry
enddef
