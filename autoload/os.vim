vim9script

const istmux = !(empty($TMUX))
const iszellij = !(empty($ZELLIJ))

# Return true if vim is in WSL environment
export def IsWsl(): bool
  return exists("$WSLENV")
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
    job_start('cmd.exe /c start "" explorer.exe /select,' .. path, job_opts)
  elseif istmux && executable("yazi")
    job_start(["tmux", "split-window", "-v", "yazi", path])
  elseif iszellij
    job_start(['zellij', 'run', '--', 'yazi', path])
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
    job_start(['wt.exe', '-d', path])
  elseif istmux
    job_start(["tmux", "split-window", "-h", "-c", path])
  elseif iszellij
    job_start(['zellij', 'action', 'new-pane', '-c', '--cwd', path, '--', $SHELL])
  endif
enddef

# Open filename in an OS
export def Open(url: string)
  var url_x = url
  if $SSH_CONNECTION != ""
    g:OSCYank(url)
    return
  endif
  dist#vim9#Open(url)
enddef


# Better gx to open URLs. https://ya.ru
# nnoremap <silent> gx :call os#Gx()<CR>
export def Gx()
  # URL regexes
  var rx_base = '\%(\%(http\|ftp\|irc\)s\?\|file\)://\S'
  var rx_bare = rx_base .. '\+'
  var rx_embd = rx_base .. '\{-}'

  var URL = ""

  # markdown URL [link text](http://ya.ru 'yandex search')
  var save_view = winsaveview()
  defer winrestview(save_view)
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

  Open(escape(URL, '#%!'))
enddef

# Pack 'ojroques/vim-oscyank'
export def Yank(s: string)
  if $SSH_CONNECTION != ""
    silent! g:OSCYank(s)
  else
    setreg('+', s)
  endif
enddef
