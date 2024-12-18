vim9script

import autoload "../autoload/utils.vim" as Utils

command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
\ | diffthis | wincmd p | diffthis
# :Reverse [[[1
command! -bar -range=% Reverse :<line1>,<line2>global/^/m <line1>-1<bar>nohl
# ChineseCount [[[1
function ChineseCount() range
  let save = @z
  silent exec 'normal! gv"zy'
  let text = @z
  let @z = save
  silent exec 'normal! gv'
  let cc = 0
  for char in split(text, '\zs')
    if char2nr(char) >= 0x2000
      let cc += 1
    endif
  endfor
  echo "Count of Chinese charasters is:"
  echo cc
endfunc

vnoremap <F7> :call <SID>ChineseCount()<cr>

# :Shuffle | Shuffle selected lines [[[1
command! -range=% Shuffle :<line1>,<line2>py3 Shuffle()
# :A [[[1
command! A call ben#a('e')
command! AV call ben#a('botright vertical split')
# :PX | chmod +x [[[1
command! PX if !empty(expand('%'))
      \|   write
      \|   call system('chmod +x ' .. expand('%'))
      \|   silent e
      \| else
      \|   echohl WarningMsg
      \|   echo 'Save the file first'
      \|   echohl None
      \| endif
# RFC [[[1
command! -bar -count=0 RFC     :e /usr/share/doc/rfc/txt/rfc<count>.txt|setl ro noma
# Paste [[[1
command! -range=% Paste :<line1>,<line2>py3 LilyPaste()
# Join [[[1
function Lilydjwg_join(sep, bang) range
  if a:sep[0] == '\'
    let sep = strpart(a:sep, 1)
  else
    let sep = a:sep
  endif
  let lines = getline(a:firstline, a:lastline)
  if a:firstline == 1 && a:lastline == line('$')
    let dellast = 1
  else
    let dellast = 0
  endif
  exe a:firstline .. ',' .. a:lastline .. 'd_'
  if a:bang != '!'
    call map(lines, "substitute(v:val, '^\\s\\+\\|\\s\\+$', '', 'g')")
  endif
  call append(a:firstline-1, join(lines, sep))
  if dellast
    $d_
  endif
endfunction
command! -nargs=1 -range=% -bang Join :<line1>,<line2>call Lilydjwg_join(<q-args>, "<bang>")
# Quote [[[1
def Quote(quote: string, bang: string)
  const q = quote == '' ? '"' : quote
  const l = getline('.')
  if l != '' || bang != '!'
    (q .. l .. q)->setline(line('.'))
  endif
enddef
command! -bang -nargs=? -range=% Quote :<line1>,<line2>call Quote(<q-args>, "<bang>")
def StrArray(line1: number, line2: number)
# StrArray [[[1
  execute printf(":%s,%sQuote", line1, line2)
  execute printf(":%s,%sJoin ,", line1, line2)
  execute printf("normal yss]")
enddef
command! -bang -nargs=? -range=% StrArray :call StrArray(<line1>, <line2>)
# Ghq [[[1
def GhqList(A: string, ...args: list<any>): list<string>
  const projs =  globpath(expand('~/ghq/github.com'), '*/*', 0, 1)
    ->map((k, x) => substitute(x, '^.*[/\\]\ze[^/\\]*[/\\]', '', ''))
  return projs->Utils.Matchfuzzy(A)
enddef
command! -nargs=1 -complete=customlist,GhqList Ghq execute 'edit ' .. expand('~/ghq/github.com/') .. <q-args>
# FollowLink [[[1
def FollowLink()
  const filepath = expand('%')
  if !filereadable(filepath)
    return
  endif
  const resolved = resolve(filepath)
  if resolved ==# filepath
    return
  endif
  echom fnameescape(resolved)
  # FIXME: dont affect other window
  # enew
  # bwipeout #
  execute 'bwipeout %'
  execute 'edit ' .. fnameescape(resolved)
  redraw
enddef
command! -nargs=0 FollowLink call <SID>FollowLink()
# Capture [[[1
const scratchFile = $HOME .. '/tmp/scratch.txt'
def Capture()
  call mkdir($HOME .. "/tmp", 'p')
  Scratch
  normal G
  silent put +
  write
enddef
command! -nargs=0 Scratch call Utils.OpenInTab(scratchFile)
command! -nargs=0 Capture call <SID>Capture()
nnoremap <silent> <leader>x :Scratch<CR>
# SetTabWidth [[[1
command! -nargs=0 SetTabWidth2 call Utils.SetTabWidth(2, true)
command! -nargs=0 SetTabWidth4 call Utils.SetTabWidth(4, true)
command! -nargs=0 SetHardTabWidth2 call Utils.SetTabWidth(2, false, 0)
command! -nargs=0 SetHardTabWidth4 call Utils.SetTabWidth(4, false, 0)
command! -nargs=0 SetHardTabWidth8 call Utils.SetTabWidth(8, false, 0)

# save and load sessions [[[1
if !isdirectory($'{$vimtmp}/session')
    mkdir($'{$vimtmp}/session', "p")
endif
command! -nargs=1 -complete=custom,SessionComplete SaveSession :exe $'mksession! {$vimtmp}/session/<args>'
command! -nargs=1 -complete=custom,SessionComplete LoadSession :%bd <bar> exe $'so {$vimtmp}/session/<args>'
def SessionComplete(_, _, _): string
    return globpath($'{$vimtmp}/session/', "*", 0, 1)->mapnew((_, v) => fnamemodify(v, ":t"))->join("\n")
enddef

# Goto [[[1
command! -nargs=1 -complete=command Command DoGotoDef("command", <f-args>)
# command! -nargs=1 -complete=customlist,MapComplete Map DoGotoDef("map", <f-args>)
command! -nargs=1 -complete=customlist,NmapComplete Imap DoGotoDef("imap", <f-args>)
command! -nargs=1 -complete=customlist,ImapComplete Nmap DoGotoDef("nmap", <f-args>)
command! -nargs=1 -complete=customlist,CmapComplete Cmap DoGotoDef("cmap", <f-args>)
command! -nargs=1 -complete=customlist,XmapComplete Xmap DoGotoDef("xmap", <f-args>)

def GotoDefComplete(kind: string, A: string, L: string, P: number): list<string>
  var l = execute(kind)->split("\n")
  l->map((_, x) => {
    const m = x->matchlist('\v^(\a)?\s+(\S+)')
    return m->len() > 2 ? m[2] : ""
  })->filter('v:val != ""')
  return  l->Utils.Matchfuzzy(A)
enddef
const MapComplete = (A: string, L: string, P: number) => GotoDefComplete("map", A, L, P)
const NmapComplete = (A: string, L: string, P: number) => GotoDefComplete("imap", A, L, P)
const ImapComplete = (A: string, L: string, P: number) => GotoDefComplete("nmap", A, L, P)
const CmapComplete = (A: string, L: string, P: number) => GotoDefComplete("cmap", A, L, P)
const XmapComplete = (A: string, L: string, P: number) => GotoDefComplete("xmap", A, L, P)

def DoGotoDef(kind: string, item: string)
  if kind == 'command' && item[0] !~# '\u'
    execute $"help {item}"
    return
  endif

  var cmdstr = $'verbose {kind} {item}'
  var lines = execute(cmdstr)->split("\n")
  for line in lines
    const m = line->matchlist('\v\s*Last set from (.+) line (\d+)')
    if !m->empty() && m[1] != null_string && m[2] != null_string
      exe $"e +{str2nr(m[2])} {m[1]}"
      return
    endif
  endfor
enddef

# ]]]
# vim:fdm=marker:fmr=[[[,]]]:ft=vim
