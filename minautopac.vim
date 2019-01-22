" https://github.com/k-takata/minpac/issues/28
function! minautopac#add(repo, ...) abort
    let l:opts = get(a:000, 0, {})
    if has_key(l:opts, 'for')
        let l:name = substitute(a:repo, '^.*/', '', '')
        let l:ft = type(l:opts.for) == type([]) ? join(l:opts.for, ',') : l:opts.for
        execut printf('autocmd FileType %s packadd %s', l:ft, l:name)
    endif
endfunction

if exists('*minpac#init')
    call minpac#init()

    command! -nargs=+ -bar Plugin call minpac#add(<args>) | call minautopac#add(<args>)
else
    " do nothing
    command! -nargs=+ Plugin call minautopac#add(<args>)
endif

command! -bar PackUpdate packadd minpac | runtime minautopac.vim | call minpac#update('', {'do': 'call minpac#status()'})
command! -bar PackClean packadd minpac | runtime minautopac.vim | call minpac#clean()
command! -bar PackStatus packadd minpac | runtime minautopac.vim| call minpac#status()

runtime! OPT ftdetect/*.vim

augroup MinAutoPac
    autocmd!
    runtime! myplugins.vim
augroup END
