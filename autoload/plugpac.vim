function! plugpac#begin()
  let s:lazy = { 'ft': {}, 'map': {}, 'cmd': {} }
  let s:repos = {}

  if exists('#PlugPac')
    augroup PlugPac
      autocmd!
    augroup END
    augroup! PlugPac
  endif

  call s:setup_command()
endfunction

function! plugpac#end()
  for [cmd, name] in items(s:lazy.cmd)
      execute printf("command! -nargs=* -range -bang %s packadd %s | call s:do_cmd('%s', \"<bang>\", <line1>, <line2>, <q-args>)", cmd, name, cmd)
  endfor

  runtime! OPT ftdetect/**/*.vim
  runtime! OPT after/ftdetect/**/*.vim

  for [ft, names] in items(s:lazy.ft)
    for name in names
      augroup PlugPac
        execute printf('autocmd FileType %s packadd %s', ft, name)
      augroup END
    endfor
  endfor
endfunction

" https://github.com/k-takata/minpac/issues/28
function! plugpac#add(repo, ...) abort
  let l:opts = get(a:000, 0, {})
  let l:name = substitute(a:repo, '^.*/', '', '')

  " `for` and `on` implies optional
  if has_key(l:opts, 'for') || has_key(l:opts, 'on')
    let l:opts['type'] = 'opt'
  endif

  if has_key(l:opts, 'for')
    let l:ft = type(l:opts.for) == type([]) ? join(l:opts.for, ',') : l:opts.for
    call s:assoc(s:lazy.ft, l:ft, l:name)
  endif

  if has_key(l:opts, 'on')
    " TODO: support list and <Plug>
    let l:cmd=l:opts.on
    if exists(":".l:cmd) != 2
      let s:lazy.cmd[l:cmd] = l:name
    endif
  endif

  let s:repos[a:repo] = l:opts
endfunction

function! plugpac#has_plugin(plugin)
  return index(s:get_plugin_list(), a:plugin) != -1
endfunction

function! s:assoc(dict, key, val)
  let a:dict[a:key] = add(get(a:dict, a:key, []), a:val)
endfunction

function! s:do_cmd(cmd, bang, start, end, args)
  exec printf('%s%s%s %s', (a:start == a:end ? '' : (a:start.','.a:end)), a:cmd, a:bang, a:args)
endfunction

function! s:setup_command()
  command! -bar -nargs=+ Pack call plugpac#add(<args>)

  command! -bar PackInstall call s:init_minpac() | call minpac#update(keys(filter(copy(minpac#pluglist), {-> !isdirectory(v:val.dir . '/.git')})))
  command! -bar PackUpdate  call s:init_minpac() | call minpac#update('', {'do': 'call minpac#status()'})
  command! -bar PackClean   call s:init_minpac() | call minpac#clean()
  command! -bar PackStatus  call s:init_minpac() | call minpac#status()
endfunction

function! s:init_minpac()
  packadd minpac

  call minpac#init()
  for [repo, opts] in items(s:repos)
    call minpac#add(repo, opts)
  endfor
endfunction

function! s:get_plugin_list()
  if exists("s:plugin_list")
    return s:plugin_list
  endif
  let l:pat = 'pack/*/*/*'
  let s:plugin_list = filter(globpath(&packpath, l:pat, 0, 1), {-> isdirectory(v:val)})
  call map(s:plugin_list, {-> substitute(v:val, '^.*[/\\]', '', '')})
  return s:plugin_list
endfunction

