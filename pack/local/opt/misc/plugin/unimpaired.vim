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

" From: https://github.com/dstein64/dotfiles/blob/master/packages/vim/.vimrc

" Move to a line based on indentation relative to the current indent.
" 'direction' can be -1 or 1 and indicates whether to move backward or
" forward. 'mode' can be -1, 0, 1, and indicates whether the relative indent
" should be less than, the same, or greater than the current indent. 'skip'
" specifies whether empty lines should be skipped.
function! s:MoveRelativeToIndent(direction, mode, skip) abort
  let l:line = line('.')
  let l:indent = indent(l:line)
  let l:last = line('$')
  let l:direction = min([max([a:direction, -1]), 1])
  while 1
    let l:line += l:direction
    if &wrapscan
      if l:line <=# 0
        let l:line = l:last
      elseif l:line >=# l:last + 1
        let l:line = 1
      endif
    endif
    if l:line ==# line('.')
      break
    endif
    if l:line <# 1 || l:line ># l:last
      break
    endif
    let l:indent2 = indent(l:line)
    if a:skip && virtcol([l:line, '$']) - 1 - l:indent2 <=# 0
      continue
    endif
    let l:diff_sign = min([max([l:indent2 - l:indent, -1]), 1])
    let l:match = (a:mode == -1 && l:diff_sign ==# a:mode)
          \ || (a:mode == 1 && l:diff_sign ==# a:mode)
          \ || (a:mode == 0 && l:diff_sign ==# a:mode)
    if l:match
      execute 'normal! ' .. l:line .. 'gg^'
      break
    endif
  endwhile
endfunction

" Go to git conflict or diff/patch hunk.
function! s:GotoConflictOrDiff(reverse) abort
  let l:flags = 'W'
  if a:reverse | let l:flags .= 'b' | endif
  call search('^\(@@ .* @@\|[<=>]\{7\}\)', l:flags)
endfunction

function! s:GotoComment(reverse) abort
  let l:flags = 'W'
  if a:reverse | let l:flags .= 'b' | endif
  let l:pattern = '\V' . substitute(&commentstring, '%s', '\\.\\*', '')
  call search(l:pattern, l:flags)
endfunction

function! s:GotoLongLine(reverse) abort
  if &textwidth ==# 0 | return | endif
  let l:flags = 'W'
  if a:reverse | let l:flags .= 'b' | endif
  let l:pattern = printf('^.\{%d\}', &textwidth + 1)
  call search(l:pattern, l:flags)
endfunction


noremap <silent> [< <cmd>call <sid>MoveRelativeToIndent(-1, -1, !v:count)<cr>
noremap <silent> ]< <cmd>call <sid>MoveRelativeToIndent(1, -1, !v:count)<cr>
noremap <silent> [= <cmd>call <sid>MoveRelativeToIndent(-1, 0, !v:count)<cr>
noremap <silent> ]= <cmd>call <sid>MoveRelativeToIndent(1, 0, !v:count)<cr>
noremap <silent> [> <cmd>call <sid>MoveRelativeToIndent(-1, 1, !v:count)<cr>
noremap <silent> ]> <cmd>call <sid>MoveRelativeToIndent(1, 1, !v:count)<cr>
noremap <silent> [n :<c-u>call <sid>GotoConflictOrDiff(1)<cr>
noremap <silent> ]n :<c-u>call <sid>GotoConflictOrDiff(0)<cr>
noremap <silent> [, :<c-u>call <sid>GotoComment(1)<cr>
noremap <silent> ], :<c-u>call <sid>GotoComment(0)<cr>
noremap <silent> [t :<c-u>call <sid>GotoLongLine(1)<cr>
noremap <silent> ]t :<c-u>call <sid>GotoLongLine(0)<cr>

" vim:set sw=2 sts=2:
