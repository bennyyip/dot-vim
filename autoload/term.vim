vim9script

class Terminal
  var bufnr: number

  def new(cmd: string = '')
    var shcmd = get(g:, 'term_shell', $SHELL)
    var opts = {
      hidden: 1,
      term_kill: 'hup',
      # TODO: add option to open in cwd
      cwd: expand('%:p:h')
    }
    opts->extend(get(g:, 'term_opts', {}))
    this.bufnr = term_start(shcmd, opts)
    setbufvar(this.bufnr, "&buflisted", 0)
    if cmd != ''
      term_sendkeys(this.bufnr, $"{cmd}\<CR>")
    endif
  enddef

  def Close()
    for winid in win_findbuf(this.bufnr)
      win_execute(winid, 'close!')
    endfor
  enddef

  def Open(vertical: bool = false)
    g:term_proportion = get(g:, "term_proportion", 0.28)

    if vertical
      exec $"silent! vertical sbuffer {this.bufnr}"
    else
      exec $"silent! bot sbuffer {this.bufnr}"
      exec $"silent! resize {float2nr(&lines * g:term_proportion)}"
      silent! setlocal winfixheight
    endif
    silent! setlocal nonumber norelativenumber
    silent! setlocal hidden
  enddef

  def IsOpen(): bool
    return win_findbuf(this.bufnr)->len() > 0
  enddef

  def IsWipedOut(): bool
    return getbufvar(this.bufnr, '&buftype') != 'terminal'
  enddef

  def SendText(text: list<string>)
    if len(text) > 0 && text[-1] =~ '^\s\+'
      text[-1] ..= "\r"
    endif
    term_sendkeys(this.bufnr, text->join("\r") .. "\r")
  enddef
endclass


var current: Terminal = null_object

export def HasCurrent(): bool
  return current != null_object && !current.IsWipedOut()
enddef

def EnsureCurrent(cmd: string = '')
  if !HasCurrent()
    var term = Terminal.new(cmd)
    current = term
  endif
enddef

export def ToggleTerminal(cmd: string = '', vertical: bool = false)
  EnsureCurrent(cmd)
  if current.IsOpen()
    current.Close()
  else
    current.Open(vertical)
  endif
enddef

export def ShowTerminal(vertical: bool = false)
  EnsureCurrent()
  if !current.IsOpen()
    current.Open(vertical)
    :wincmd p
  endif
enddef

export def DeleteTerminal()
  if HasCurrent()
    execute $":{current.bufnr}bwipeout!"
    current = null_object
  endif
enddef

def Error(msg: string)
  echom $"term.vim: {msg}"
enddef

# handle python repl
# 1. remove indent of the first non empty line
# 2. insert empty line before top level statements
def PrepareText(text: list<string>): list<string>
  var result: list<string> = []
  if empty(text)
    return result
  endif
  var indent_remove = -1
  for line in text
    if indent_remove == -1 && line !~ '^\s*$'
      indent_remove = line->matchstr('^\s*')->len()
    endif
    var line_res = line->substitute('^\s\{' .. indent_remove .. '}', '', '')
    if line_res =~ '^$'
      line_res = ' '
    endif
    if line_res =~ '^\S' && len(result) > 0
      result->add("")
    endif
    result->add(line_res)
  endfor
  return result
enddef

export def Send(...args: list<any>): string
  if !HasCurrent()
    Error("There is no terminal!")
    return ""
  endif

  if len(args) == 0
    w:opfuncview = winsaveview()
    &opfunc = matchstr(expand('<stack>'), '[^. ]*\ze[')
    return 'g@'
  endif

  var region_type = {line: "V", char: "v", block: "\<c-v>"}
  var text = PrepareText(getregion(getpos("'["),
    getpos("']"),
    {type: get(region_type, args[0])}))

  SendText(text)
  if exists("w:opfuncview")
    winrestview(w:opfuncview)
    unlet w:opfuncview
  endif
  return ""
enddef

export def SendText(text: list<string>): string
  if !HasCurrent()
    Error( "There is no terminal!")
    return ""
  endif

  current.SendText(text)
  return ""
enddef

export def SendLine(...args: list<any>): string
  SendText([args->join(' ')])
  return ""
enddef

export def TerminalMap(map: string, com: string)
  execute $"inoremap <silent> {map} <Esc>{com}"
  execute $"nnoremap <silent> {map} {com}"
  execute $"tnoremap <silent> {map} <C-\\><C-n>{com}"
enddef

export def Run(cmd: string, mods: string)
  var cwd = getcwd()
  var term_name = $'!{cmd}'
  var termbuf = term_list()->filter((_, v) => term_getstatus(v) != 'running')
  var bufnr = !empty(termbuf) ? termbuf[0] : -1
  defer () => {
    if bufnr != -1
      silent! exe "bw!" bufnr
    endif
  }()
  if !win_gotoid(bufwinid(bufnr)) && bufnr != -1
    exe $"{mods} sbuffer {bufnr}"
  elseif bufnr == -1
    var counter = 1
    while !empty(term_list()->filter((_, v) => bufname(v) == term_name))
      term_name = term_name->substitute('\( (\d\+)\)\?$', $' ({counter})', '')
      counter += 1
    endwhile
    exe $"{mods} split"
  endif

  term_start([&shell, &shellcmdflag, cmd], {
    term_name: term_name,
    curwin: true,
    cwd: cwd,
  })
enddef

export def ReRun()
  if bufnr()->term_getstatus() == 'finished'
    Run(bufname()[1 : ], '')
  endif
enddef
