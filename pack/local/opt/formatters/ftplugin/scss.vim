if !executable('dprint') | finish | endif

augroup formatprgsScss
  autocmd! * <buffer>
  autocmd ShellFilterPost <buffer> if v:shell_error | execute 'echom "shell filter returned error " . v:shell_error . ", undoing changes"' | undo | endif

  let &l:formatprg = 'dprint fmt --stdin scss'
augroup END

