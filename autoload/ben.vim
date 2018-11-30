function! ben#foldy()
  let linelen = &tw ? &tw : 80
  let marker  = strpart(&fmr, 0, stridx(&fmr, ',')) . '\d*'
  let range   = foldclosedend(v:foldstart) - foldclosed(v:foldstart) + 1

  let left    = substitute(getline(v:foldstart), marker, '', '')
  let leftlen = len(left)

  let right    = range . ' [' . v:foldlevel . ']'
  let rightlen = len(right)

  let tmp    = strpart(left, 0, linelen - rightlen)
  let tmplen = len(tmp)

  if leftlen > len(tmp)
    let left    = strpart(tmp, 0, tmplen - 4) . '... '
    let leftlen = tmplen
  endif

  let fill = repeat(' ', linelen - (leftlen + rightlen))

  return left . fill . right . repeat(' ', 100)
endfunction

" Function: #quote {{{1
function! s:get_random_offset(max) abort
  return str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:]) % a:max
endfunction
function! ben#quote() abort
  let quote = s:quotes[s:get_random_offset(len(s:quotes))]
  let lines = []
  for l in quote
    let offset = 50 - strwidth(l)
    let lines += [repeat(' ', offset).l ]
  endfor
  return lines
endfunction

let s:quotes = [
      \ ["「世界上有什麼不會失去的東西嗎？」","「我相信有，妳也最好相信。」"],
      \ ["「獨步天下，吾心自潔，無欲無求，如林中之象」"],
      \ ["「生死去來，棚頭傀儡，一線斷時，落落磊磊。」"],
      \ ["「懷舊是戀尸癖的早期症狀。」"],
      \ ["「你我猶如隔鏡視物所見無非虛幻迷濛」"],
      \ ["Brute force never fails, unless you're not using enought of it."]
      \] 
