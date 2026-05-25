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


if !executable("cmd.exe")
  export def RestoreShell()
  enddef
  export def ForceCmdexe()
  enddef
else
  export def RestoreShell()
    &shell = shell
    &shellslash = shellslash
    &shellcmdflag = shellcmdflag
  enddef
  export def ForceCmdexe()
    if &shell !~? "cmd" || &shellslash
      shell = &shell
      shellslash = &shellslash
      shellcmdflag = &shellcmdflag

      &shell = $COMSPEC
      set noshellslash shellcmdflag=/c
    endif
  enddef
endif

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
export def FileManager(cmd: list<string> = [])
  ForceCmdexe()
  defer RestoreShell()

  var path = ''
  if expand("%:p") == ""
    path = expand("%:p:h")
  else
    path = expand("%:p")
  endif
  path = substitute(path, "^dir://", "", "")
  var select = isdirectory(path) ? "" : "--select"

  if !cmd->empty()
    job_start(cmd->deepcopy()->add(path))
    return
  endif

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

  ForceCmdexe()
  defer RestoreShell()
  vim9.Open(url)
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

export def Yazi(path: string)
  const chooser_file = tempname()

  const p = path->expand()->substitute("^dir://", "", "")->shellescape()
  silent execute $'!yazi --chooser-file {shellescape(chooser_file)} {p}'

  if filereadable(chooser_file)
    const files = readfile(chooser_file)

    if files->len() > 1
      # :cfdo tabnew
      setqflist(files->mapnew((i, f) => {
        return { filename: f->simplify()->fnamemodify(":~:."), lnum: 1, col: 1, text: $'yazi: {i + 1} of {files->len()}' }
      }))
      botright copen
    else
      const simplified_path = simplify(files[0])
      execute $'edit {files[0]->simplify()->fnamemodify(":~:.")}'
    endif
    delete(chooser_file)
  endif

  redraw!
enddef

# local docs
export def Doc(args: string)
  if args =~? '^c'
    Open($HOME .. '/cppreference/en/index.html')
  elseif args =~? '^l'
    Open($HOME .. '/luadoc/lua53doc-gh-pages/manual.html')
  elseif args =~? '^p'
    Open($HOME .. '/python/Doc/html/library/stdtypes.html')
  elseif args =~? '^m'
    Open($HOME .. '/mpv/doc/mpv.html')
  endif
enddef
