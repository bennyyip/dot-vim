vim9script
# :Reverse [[[2
command! -bar -range=% Reverse :<line1>,<line2>global/^/m <line1>-1<bar>nohl
# ChineseCount [[[2
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

# :Shuffle | Shuffle selected lines [[[2
command! -range=% Shuffle :<line1>,<line2>py3 Shuffle()
# :A [[[2
command! A call ben#a('e')
command! AV call ben#a('botright vertical split')
# :PX | chmod +x [[[2
command! PX if !empty(expand('%'))
      \|   write
      \|   call system('chmod +x '.expand('%'))
      \|   silent e
      \| else
      \|   echohl WarningMsg
      \|   echo 'Save the file first'
      \|   echohl None
      \| endif
# RFC [[[2
command! -bar -count=0 RFC     :e /usr/share/doc/rfc/txt/rfc<count>.txt|setl ro noma
# Paste [[[2
command! -range=% Paste :<line1>,<line2>py3 LilyPaste()
# 使用分隔符连接多行 [[[2
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
# Quote [[[2
def Quote(quote: string, bang: string)
  const q = quote == '' ? '"' : quote
  const l = getline('.')
  if l != '' || bang == '!'
    (q .. l .. q)->setline(line('.'))
  endif
enddef
command! -bang -nargs=? -range=% Quote :<line1>,<line2>call Quote(<q-args>, "<bang>")
# vim:fdm=marker:fmr=[[[,]]]:ft=vim
