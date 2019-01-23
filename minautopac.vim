if exists('*minpac#init')
  call minpac#init()
  let s:minpac_init=1
else
  let s:minpac_init=0
endif

function! s:assoc(dict, key, val)
  let a:dict[a:key] = add(get(a:dict, a:key, []), a:val)
endfunction

function! s:do_cmd(cmd, bang, start, end, args)
  exec printf('%s%s%s %s', (a:start == a:end ? '' : (a:start.','.a:end)), a:cmd, a:bang, a:args)
endfunction

" https://github.com/k-takata/minpac/issues/28
function! minautopac#add(repo, ...) abort
  let l:opts = get(a:000, 0, {})
  let l:name = substitute(a:repo, '^.*/', '', '')

  " `for` and `on` implies optional
  if has_key(l:opts, 'for') || has_key(l:opts, 'on')
    let l:opts['type'] = 'opt'
  endif

  if has_key(l:opts, 'for')
    let l:ft = type(l:opts.for) == type([]) ? join(l:opts.for, ',') : l:opts.for
    execute printf('autocmd FileType %s packadd %s', l:ft, l:name)
  endif

  if has_key(l:opts, 'on')
    let l:cmd=l:opts.on " TODO: support list and <Plug>
    if exists(":".l:cmd) != 2
      execute printf("command! -nargs=* -range -bang %s packadd %s | call s:do_cmd('%s', \"<bang>\", <line1>, <line2>, <q-args>)", l:cmd, l:name, l:cmd)
    endif
  endif

  if s:minpac_init
    call minpac#add(a:repo, l:opts)
  endif

endfunction

command! -nargs=+ Plug call minautopac#add(<args>)

command! PackInstall packadd minpac | runtime minautopac.vim | call minpac#update(keys(filter(copy(minpac#pluglist), {-> !isdirectory(v:val.dir . '/.git')})))
command! PackUpdate  packadd minpac | runtime minautopac.vim | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean   packadd minpac | runtime minautopac.vim | call minpac#clean()
command! PackStatus  packadd minpac | runtime minautopac.vim | call minpac#status()

runtime! OPT ftdetect/*.vim

augroup MinAutoPac
  autocmd!
  runtime! plugins.vim
augroup END
