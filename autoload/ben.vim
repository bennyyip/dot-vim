let s:is_win = has('win32')
" Function: #foldy ('foldtext') {{{1
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
" Function: #tab_or_complete (use <tab> to invoke and select complete) {{{1
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
" Function: #a (switch between .cc and .h) {{{1
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
    exe "sil !start cmd /cstart /b ".a:url.""
  else
    exe "sil !firefox \"".a:url."\"&"
  endif
endfunction
" Function: #shuffle (shuffle lines) {{{1
function! ben#shuffle() range
  ruby << RB
  first, last = %w[a:firstline a:lastline].map { |e| VIM::evaluate(e).to_i }
  (first..last).map { |l| $curbuf[l] }.shuffle.each_with_index do |line, i|
  $curbuf[first + i] = line
end
RB
endfunction
" Function: #open_explore (0: current buffer, 1: vnew, 2: tabnew) {{{1
function! ben#open_explore(where)
    let l:path = expand("%:p:h")
    if l:path == ''
        let l:path = getcwd()
    endif
    if a:where == 0
        exec 'Explore '.fnameescape(l:path)
    elseif a:where == 1
        exec 'vnew'
        exec 'Explore '.fnameescape(l:path)
    else
        exec 'tabnew'
        exec 'Explore '.fnameescape(l:path)
    endif
  endfunction
" Function: #has_plugin (require junegunn/plug) {{{1
function! ben#has_plugin(plugin)
  return index(g:plugs_order, a:plugin) != -1
endfunction
" Function: #quote (random quote on splash screen) {{{1
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
" Function: #votl {{{1
function! ben#votl()
  let filename = expand("~/votl/". strftime('%Y/%m/%d'). '.otl')
  let votl_dir = fnamemodify(filename, ':h')
  if !isdirectory(votl_dir)
    call mkdir(votl_dir, 'p')
  endif
  execute 'edit' fnameescape(filename)
endfunction
" Function: #syninfo {{{1
function! s:synnames()
  let syn                 = {}
  let [lnum, cnum]        = [line('.'), col('.')]
  let [effective, visual] = [synID(lnum, cnum, 0), synID(lnum, cnum, 1)]
  let syn.effective       = synIDattr(effective, 'name')
  let syn.effective_link  = synIDattr(synIDtrans(effective), 'name')
  let syn.visual          = synIDattr(visual, 'name')
  let syn.visual_link     = synIDattr(synIDtrans(visual), 'name')
  return syn
endfunction

function! ben#syninfo()
  let syn = s:synnames()
  let info = ''
  if syn.visual != ''
    let info .= printf('visual: %s', syn.visual)
    if syn.visual != syn.visual_link
      let info .= printf(' (as %s)', syn.visual_link)
    endif
  endif
  if syn.effective != syn.visual
    if syn.visual != ''
      let info .= ', '
    endif
    let info .= printf('effective: %s', syn.effective)
    if syn.effective != syn.effective_link
      let info .= printf(' (as %s)', syn.effective_link)
    endif
  endif
  return info
endfunction
" Function: #save_change_marks #restore_change_marks {{{1
"do not clobber '[ '] on :write
function! ben#save_change_marks() abort
  let s:change_marks = [getpos("'["), getpos("']")]
endfunction
function! ben#restore_change_marks() abort
  call setpos("'[", s:change_marks[0])
  call setpos("']", s:change_marks[1])
endfunction
" Modeline {{{1
" vim:fdm=marker
