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

"
" Make <tab> a little bit more useful. Stolen from @junegunn.
"
function! s:can_complete(func, prefix)
  if empty(a:func) || call(a:func, [1, '']) < 0
    return 0
  endif
  let result = call(a:func, [0, matchstr(a:prefix, '\k\+$')])
  return !empty(type(result) == type([]) ? result : result.words)
endfunction

function! ben#tab_yeah(k, o)
  if pumvisible()
    return a:k
  endif

  let line = getline('.')
  let col = col('.') - 2
  if empty(line) || line[col] !~ '\k\|[/~.]' || line[col + 1] =~ '\k'
    return a:o
  endif

  let prefix = expand(matchstr(line[0:col], '\S*$'))
  if prefix =~ '^[~/.]'
    return "\<c-x>\<c-f>"
  endif
  if s:can_complete(&omnifunc, prefix)
    return "\<c-x>\<c-o>"
  endif
  if s:can_complete(&completefunc, prefix)
    return "\<c-x>\<c-u>"
  endif
  return a:k
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
