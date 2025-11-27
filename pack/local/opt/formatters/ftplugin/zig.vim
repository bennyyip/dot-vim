if !executable('zig') | finish | endif

augroup formatprgsZig
  autocmd! * <buffer>
  autocmd ShellFilterPost <buffer> if v:shell_error | execute 'echom "shell filter returned error " . v:shell_error . ", undoing changes"' | undo | endif

  let &l:formatprg = 'zig fmt --stdin'
augroup END


