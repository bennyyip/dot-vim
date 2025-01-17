augroup formatprgsOcaml
  autocmd! * <buffer>
  if exists('##ShellFilterPost')
    autocmd ShellFilterPost <buffer> if v:shell_error | execute 'echom "shell filter returned error " . v:shell_error . ", undoing changes"' | undo | endif
  endif
augroup END

let &l:formatprg=$'ocamlformat --profile=janestreet --enable-outside-detected-project --name {expand("%:p")->fnameescape()} -'

function! s:DebugStringFunBase(desc, var)
  return $'Printf.printf "{a:desc} %d\n" {a:var};'
endfunc

command! -buffer -nargs=0 AddDebugString
            \ put=s:DebugStringFunBase(g:DebugstringPrefixStr(), g:debugStringCounter)
command! -buffer -nargs=1 AddDebugStringExpr
            \ put=s:DebugStringFunBase(<args> . ': ', <args>)
