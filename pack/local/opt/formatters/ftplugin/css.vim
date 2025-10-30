if !executable('dprint') | finish | endif

augroup formatprgsCss
  autocmd! * <buffer>
  autocmd ShellFilterPost <buffer> if v:shell_error | execute 'echom "shell filter returned error " . v:shell_error . ", undoing changes"' | undo | endif

  let &l:formatprg = 'dprint fmt --stdin css'
augroup END

