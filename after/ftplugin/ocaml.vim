" augroup formatprgsOcaml
"   autocmd! * <buffer>
"   if exists('##ShellFilterPost')
"     autocmd ShellFilterPost <buffer> if v:shell_error | execute 'echom "shell filter returned error " . v:shell_error . ", undoing changes"' | undo | endif
"   endif
" augroup END

" let &l:formatprg=$'ocamlformat --profile=janestreet --enable-outside-detected-project --name {expand("%:p")->fnameescape()} -'

nnoremap <buffer> <expr> <leader>T term#SendLine($'#use "{expand("%:t")}";;')

let b:AutoPairs = {'"': '"', '[': ']', '(': ')', '{': '}'}
