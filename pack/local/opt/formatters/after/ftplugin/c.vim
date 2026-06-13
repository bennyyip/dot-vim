vim9script
augroup formatprgsC
  autocmd! * <buffer>
  if exists('##ShellFilterPost')
    autocmd ShellFilterPost <buffer> if v:shell_error | execute 'echom "shell filter returned error "..v:shell_error..", undoing changes"' | undo | endif
  endif
augroup END

setlocal formatprg=clang-format

