if !executable('biome') | finish | endif

augroup formatprgsTypeScript
  autocmd! * <buffer>
  autocmd ShellFilterPost <buffer> if v:shell_error | execute 'echom "shell filter returned error " . v:shell_error . ", undoing changes"' | undo | endif

  let b:formatprg_cmd = 'biome format ' . get(b:, 'formatprg_args', '--write --format-with-errors=true --colors=off') . ' '
  let &l:formatprg = b:formatprg_cmd . ' ' .
        \ '--stdin-file-path=' . expand('%:p:S') . ' ' .
        \ (&textwidth > 0 ? '--line-width=' . &textwidth . ' ' : '') .
        \ '--indent-width=' . 2 . ' ' .
        \ '--semicolons=as-needed'
augroup END
