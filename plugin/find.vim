vim9script

if !has("patch-9.1.1230")
  finish
endif

import autoload '../autoload/rooter.vim'

var ignore: bool = true

def FindCmd(): string
  var cmd = ''
  if executable('fd')
    cmd = 'fd . --path-separator / --type f --strip-cwd-prefix --hidden --follow --exclude .git --exclude .vscode --exclude __pycache__'
    if !ignore
      cmd ..= ' -I'
    endif
  elseif executable('fdfind')
    cmd = 'fdfind . --path-separator / --type f --strip-cwd-prefix --hidden --follow --exclude .git --exclude .vscode --exclude __pycache__'
    if !ignore
      cmd ..= ' -I'
    endif
  elseif executable('ugrep')
    cmd = 'ugrep "" -Rl -I --ignore-files'
  elseif executable('rg')
    cmd = 'rg --path-separator / --files --hidden --glob !.git'
  elseif executable('find')
    cmd = 'find \! \( -path "*/.git" -prune -o -name "*.swp" \) -type f -follow'
  endif
  return cmd
enddef

if executable('fzf')
  $FZF_DEFAULT_OPTS = $'--bind tab:down,shift-tab:up --layout=reverse'
  g:fzy = {
    exe: exepath('fzf')->tr('\', '/'),
    showinfo: true,
    lines: 15,
    popupwin: true,
    findcmd: FindCmd(),
    popup: {
      minwidth: 100,
      highlight: 'Normal',
      borderhighlight: ['GreyDark'],
      borderchars: ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
    }
  }

  def Fd(dir: string)
    g:fzy.findcmd = FindCmd()
    fzy#Find(dir)
  enddef
else
  var files_cache: list<string> = []
  var saved_cwd: string = ''


  def Fd(dir: string)
    saved_cwd = getcwd()->fnamemodify(':p')

    # find is canceled
    autocmd CmdlineLeave : ++once {
      if v:char != "\015" # <CR>
        RestoreCwd()
      endif
    }

    autocmd BufWinEnter * ++once {
      if !empty(saved_cwd)
        RestoreCwd()
      endif
    }

    chdir(dir)
    feedkeys(':find ')
  enddef

  def RestoreCwd()
    chdir(saved_cwd)
    saved_cwd = ''
  enddef

  augroup find
    autocmd CmdlineEnter * {
      files_cache = []
    }
  augroup END

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

  set findfunc=Find
endif


def BufDir(): string
  return &ft == 'dir' ? expand('%:.')->substitute("^dir://", "", "") : expand('%:.:h')
enddef

def SearchProject(_ignore: bool = true)
  const saved_ignore = ignore
  ignore = _ignore
  defer () => {
    ignore = saved_ignore
  }()
  const root = rooter.FindRootDirectory()
  if root == ''
    Fd(BufDir())
  else
    Fd(root)
  endif
enddef

nnoremap <leader>ff <scriptcmd>SearchProject()<cr>
nnoremap <leader>fF <scriptcmd>SearchProject(false)<cr>
nnoremap <leader>. <scriptcmd>Fd(BufDir())<cr>
nnoremap <leader>fp <scriptcmd>Fd(expand("$MYVIMDIR"))<cr>
nnoremap <leader>fd <scriptcmd>Fd($HOME .. "/dotfiles")<cr>
nnoremap <leader>fR <scriptcmd>Fd(expand("$VIMRUNTIME"))<cr>
nnoremap <leader>fo <scriptcmd>Fd(g:obsidian_vault)<cr>

command -bang -nargs=1 -complete=dir Fd Fd(<f-args>, <q-bang> == '!')
