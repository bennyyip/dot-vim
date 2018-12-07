let s:is_win = has('win32')
" Function: #foldy {{{1
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

" Function: #gen_def {{{1
function! ben#gen_def()
  normal! 0yf;
  call s:a('e')
  normal! Go
  normal! p;cl {
  normal! o}
  normal! O
  normal! cc
endfunction

" Function: #tab_or_complete {{{1
function! ben#tab_or_complete() abort
  " If completor is already open the `tab` cycles through suggested completions.
  if pumvisible()
    return "\<C-N>"
    " If completor is not open and we are in the middle of typing a word then
    " `tab` opens completor menu.
  elseif col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-R>=completor#do('complete')\<CR>"
  else
    " If we aren't typing a word and we press `tab` simply do the normal `tab`
    " action.
    return "\<Tab>"
  endif
endfunction

" Function: #a {{{1
function! ben#a(cmd)
  let l:name = expand('%:r')
  let l:ext = tolower(expand('%:e'))
  let l:sources = ['c', 'cc', 'cpp', 'cxx', 'mli']
  let l:headers = ['h', 'hh', 'hpp', 'hxx', 'ml']
  for l:pair in [[l:sources, l:headers], [l:headers, l:sources]]
    let [l:set1, l:set2] = l:pair
    if index(l:set1, l:ext) >= 0
      for l:h in l:set2
        let l:aname = l:name.'.'.l:h
        for l:a in [l:aname, toupper(l:aname)]
          if filereadable(l:a)
            execute a:cmd l:a
            return
          end
        endfor
      endfor
    endif
  endfor
endfunction

" Function: #open_url {{{1
function! ben#open_url(url)
  if s:is_win
    exe "!start cmd /cstart /b ".a:url.""
  else
    exe "AsyncRun firefox \"".a:url."\"&"
  endif
endfunction
" Function: #shuffle {{{1
function! ben#shuffle() range
  ruby << RB
  first, last = %w[a:firstline a:lastline].map { |e| VIM::evaluate(e).to_i }
  (first..last).map { |l| $curbuf[l] }.shuffle.each_with_index do |line, i|
  $curbuf[first + i] = line
end
RB
endfunction

" Function: #map_switch_tab {{{1
function! ben#map_switch_tab()
  for l:i in range(9)
    exe "nnoremap <leader>".l:i." :tabn ".l:i."<cr>"
  endfor
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
