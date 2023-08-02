vim9script

import autoload "./autoload/utils.vim" as Utils

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
      \|   call system('chmod +x '.expand('%'))
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
# StrArray [[[1
def StrArray(line1: number, line2: number)
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
command! -nargs=0 Scratch execute $"edit {scratchFile}"
command! -nargs=0 Capture call <SID>Capture()
# ]]]

# vim:fdm=marker:fmr=[[[,]]]:ft=vim
