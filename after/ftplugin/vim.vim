vim9script

def Help(args: string)
  const syn_name = synIDattr(synID(line('.'), col('.'), 1), 'name')

  if syn_name =~# 'vimCommand'
    execute $'help :{args}'
  elseif syn_name =~# 'vimOption'
    execute $"help '{args}'"
  elseif syn_name =~# 'vimFunc'
    execute $'help {args}()'
  else
    execute $'help {args}'
  endif
enddef

command! -buffer -nargs=1 Help Help(<q-args>)
setlocal keywordprg=:Help
