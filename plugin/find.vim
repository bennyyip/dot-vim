vim9script

var files_cache: list<string> = []
var saved_cwd: string = ''

def FindCmd(): string
  var cmd = ''
  if executable('fd')
    cmd = 'fd . --path-separator / --type f --hidden --follow --exclude .git'
  elseif executable('fdfind')
    cmd = 'fdfind . --path-separator / --type f --hidden --follow --exclude .git'
  elseif executable('ugrep')
    cmd = 'ugrep "" -Rl -I --ignore-files'
  elseif executable('rg')
    cmd = 'rg --path-separator / --files --hidden --glob !.git'
  elseif executable('find')
    cmd = 'find \! \( -path "*/.git" -prune -o -name "*.swp" \) -type f -follow'
  endif
  return cmd
enddef

def Find(cmd_arg: string, cmd_complete: bool): list<string>
  if empty(files_cache)
    var cmd = FindCmd()
    if empty(cmd)
      files_cache = globpath('.', '**', 1, 1)
    else
      files_cache = systemlist(cmd)
    endif
  endif
  if empty(cmd_arg)
    return files_cache
  else
    return files_cache->matchfuzzy(cmd_arg)
  endif
enddef


augroup find
  autocmd CmdlineEnter * {
    files_cache = []
  }
  autocmd BufWinEnter * {
    if !empty(saved_cwd)
      chdir(saved_cwd, 'window')
      saved_cwd = ''
    endif
  }
augroup END

set findfunc=Find

def Fd(dir: string, keepcwd: bool = true)
  if keepcwd
    saved_cwd = getcwd()->fnamemodify(':p')
  endif
  chdir(dir, 'window')
  # pwd
  feedkeys(':find ')
enddef

def BufDir(): string
  return &ft == 'dir' ? expand('%:.')->substitute("^dir://", "", "") : expand('%:.:h')
enddef

def SearchProject()
  const root = g:FindRootDirectory()
  if root == ''
    Fd(BufDir())
  else
    Fd(root)
  endif
enddef

nnoremap <leader>ff <scriptcmd>SearchProject()<cr>
nnoremap <leader>. <scriptcmd>Fd(BufDir())<cr>
nnoremap <leader>fF :<C-U>find<space>
nnoremap <leader>fp <scriptcmd>Fd(expand("$MYVIMDIR"))<cr>
nnoremap <leader>fR <scriptcmd>Fd(expand("$VIMRUNTIME"))<cr>

command -bang -nargs=1 -complete=dir Fd Fd(<f-args>, "<bang>" == '!')
