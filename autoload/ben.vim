let s:is_win = has('win32')
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
