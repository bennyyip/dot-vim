vim9script

import autoload 'shout.vim'

def Rerun()
  if &filetype == 'shout'
    setpos('.', [0, 0, 0])
    shout.OpenFile()
  else
    feedkeys(":Sh\<UP>\<CR>")
  endif
enddef

noremap <F9> <scriptcmd>Rerun()<CR>

command -nargs=+ -complete=shellcmdline Shf {
  execute "Sh " .. (<q-args>) ..  ' ' .. shellescape(expand("%:p"))
}
