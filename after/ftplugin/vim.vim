vim9script

def Help(args: string)
  const syn_name = synIDattr(synID(line('.'), col('.'), 1), 'name')

  const cmd = 'vertical help'

  if syn_name =~# 'vimCommand'
    execute $'{cmd} :{args}'
  elseif syn_name =~# 'vimOption'
    execute $"{cmd} '{args}'"
  elseif syn_name =~# 'vimFunc'
    execute $'{cmd} {args}()'
  else
    execute $'{cmd} {args}'
  endif
enddef

command! -buffer -nargs=1 Help Help(<q-args>)
setlocal keywordprg=:Help
