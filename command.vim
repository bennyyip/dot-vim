" :Reverse [[[2
command! -bar -range=% Reverse <line1>,<line2>global/^/m<line1>-1<bar>nohl
" ChineseCount [[[2
function! ChineseCount() range
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

vnoremap <F7> :call ChineseCount()<cr>

" :Shuffle | Shuffle selected lines [[[2
command! -range Shuffle <line1>,<line2>call ben#shuffle()
" :A [[[2
command! A call ben#a('e')
command! AV call ben#a('botright vertical split')
" :PX | chmod +x [[[2
command! PX if !empty(expand('%'))
      \|   write
      \|   call system('chmod +x '.expand('%'))
      \|   silent e
      \| else
        \|   echohl WarningMsg
        \|   echo 'Save the file first'
        \|   echohl None
        \| endif
" RFC [[[2
command! -bar -count=0 RFC     :e /usr/share/doc/rfc/txt/rfc<count>.txt|setl ro noma
" Paste [[[2
command -range=% Paste <line1>,<line2>py3 LilyPaste()

" vim:fdm=marker:fmr=[[[,]]]:ft=vim
