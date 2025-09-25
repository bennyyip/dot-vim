" unimpaired.vim - Pairs of handy bracket mappings
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      2.1
" GetLatestVimScripts: 1590 1 :AutoInstall: unimpaired.vim

if exists("g:loaded_unimpaired") || &cp || v:version < 700
  finish
endif
let g:loaded_unimpaired = 1

function! s:Map(...) abort
  let [mode, head, rhs; rest] = a:000
  let flags = get(rest, 0, '') . (rhs =~# '^<Plug>' ? '' : '<script>')
  let tail = ''
  let keys = get(g:, mode.'remap', {})
  if type(keys) == type({}) && !empty(keys)
    while !empty(head) && len(keys)
      if has_key(keys, head)
        let head = keys[head]
        if empty(head)
          let head = '<skip>'
        endif
        break
      endif
      let tail = matchstr(head, '<[^<>]*>$\|.$') . tail
      let head = substitute(head, '<[^<>]*>$\|.$', '', '')
    endwhile
  endif
  if head !=# '<skip>' && empty(maparg(head.tail, mode))
    return mode.'map ' . flags . ' ' . head.tail . ' ' . rhs
  endif
  return ''
endfunction

" Section: Line operations

function! s:BlankUp() abort
  let cmd = 'put!=repeat(nr2char(10), v:count1)|silent '']+'
  if &modifiable
    let cmd .= '|silent! call repeat#set("\<Plug>(unimpaired-blank-up)", v:count1)'
  endif
  return cmd
endfunction

function! s:BlankDown() abort
  let cmd = 'put =repeat(nr2char(10), v:count1)|silent ''[-'
  if &modifiable
    let cmd .= '|silent! call repeat#set("\<Plug>(unimpaired-blank-down)", v:count1)'
  endif
  return cmd
endfunction

nnoremap <silent> <Plug>(unimpaired-blank-up)   :<C-U>exe <SID>BlankUp()<CR>
nnoremap <silent> <Plug>(unimpaired-blank-down) :<C-U>exe <SID>BlankDown()<CR>

nnoremap <silent> <Plug>unimpairedBlankUp   :<C-U>exe <SID>BlankUp()<CR>
nnoremap <silent> <Plug>unimpairedBlankDown :<C-U>exe <SID>BlankDown()<CR>

exe s:Map('n', '[<Space>', '<Plug>(unimpaired-blank-up)')
exe s:Map('n', ']<Space>', '<Plug>(unimpaired-blank-down)')

function! s:ExecMove(cmd) abort
  let old_fdm = &foldmethod
  if old_fdm !=# 'manual'
    let &foldmethod = 'manual'
  endif
  normal! m`
  silent! exe a:cmd
  norm! ``
  if old_fdm !=# 'manual'
    let &foldmethod = old_fdm
  endif
endfunction

function! s:Move(cmd, count, map) abort
  call s:ExecMove('move'.a:cmd.a:count)
  silent! call repeat#set("\<Plug>(unimpaired-move-".a:map.")", a:count)
endfunction

function! s:MoveSelectionUp(count) abort
  call s:ExecMove("'<,'>move'<--".a:count)
  silent! call repeat#set("\<Plug>(unimpaired-move-selection-up)", a:count)
endfunction

function! s:MoveSelectionDown(count) abort
  call s:ExecMove("'<,'>move'>+".a:count)
  silent! call repeat#set("\<Plug>(unimpaired-move-selection-down)", a:count)
endfunction

nnoremap <silent> <Plug>(unimpaired-move-up)            :<C-U>call <SID>Move('--',v:count1,'up')<CR>
nnoremap <silent> <Plug>(unimpaired-move-down)          :<C-U>call <SID>Move('+',v:count1,'down')<CR>
noremap  <silent> <Plug>(unimpaired-move-selection-up)   :<C-U>call <SID>MoveSelectionUp(v:count1)<CR>
noremap  <silent> <Plug>(unimpaired-move-selection-down) :<C-U>call <SID>MoveSelectionDown(v:count1)<CR>
nnoremap <silent> <Plug>unimpairedMoveUp            :<C-U>call <SID>Move('--',v:count1,'up')<CR>
nnoremap <silent> <Plug>unimpairedMoveDown          :<C-U>call <SID>Move('+',v:count1,'down')<CR>
noremap  <silent> <Plug>unimpairedMoveSelectionUp   :<C-U>call <SID>MoveSelectionUp(v:count1)<CR>
noremap  <silent> <Plug>unimpairedMoveSelectionDown :<C-U>call <SID>MoveSelectionDown(v:count1)<CR>

exe s:Map('n', '[e', '<Plug>(unimpaired-move-up)')
exe s:Map('n', ']e', '<Plug>(unimpaired-move-down)')
exe s:Map('x', '[e', '<Plug>(unimpaired-move-selection-up)')
exe s:Map('x', ']e', '<Plug>(unimpaired-move-selection-down)')

" vim:set sw=2 sts=2:
