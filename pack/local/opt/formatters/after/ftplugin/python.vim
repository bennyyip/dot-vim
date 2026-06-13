augroup formatprgsPython
  autocmd! * <buffer>
  if exists('##ShellFilterPost')
    autocmd ShellFilterPost <buffer> if v:shell_error | echohl WarningMsg | echomsg printf('shell filter returned error %d, undoing changes', v:shell_error) | echohl None | silent! undo | endif
  endif
augroup END

if !executable(get(b:, 'formatprg', '')) | let b:formatprg = '' | endif
if b:formatprg ==# 'ruff' || empty(b:formatprg) && executable('ruff')
  let b:formatprg_cmd = 'ruff format ' . get(b:, 'formatprg_args', '--quiet --preview') . ' '
  function! s:RuffFormatexpr() abort
    let start = v:lnum
    let end   = v:lnum + v:count - 1
    let cmd = b:formatprg_cmd .
          \ (&textwidth > 0 ? ' --line-length=' . &textwidth : '' ) .
          \ (filereadable(expand('%')) ? ' --stdin-filename ' . expand('%:p:S') : '') .
          \  printf(' --range=%d-%d -', start, end)
    let view  = winsaveview()
    try
      silent execute '%!' . cmd
    finally
      call winrestview(view)
    endtry
  endfunction

  setlocal formatexpr=<SID>RuffFormatexpr()
endif

let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin . ' | ' : '') .
      \ 'setlocal formatprg< formatexpr< | unlet! b:formatprg b:formatprg_cmd b:formatprg_args | silent! autocmd! formatprgsPython * <buffer>'

