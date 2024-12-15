vim9script
g:dir_columns = "name"
g:dir_show_hidden = v:false


nmap -  :<C-u>Dir %:p:h<CR>

import autoload 'dir/action.vim'

def CustomizeMappings()
  # Customize key mappings here
  nmap <buffer> gg 4G
  noremap <buffer> < <scriptcmd>action.WidenView(v:count > 0)<cr>
  noremap <buffer> > <scriptcmd>action.ShrinkView(v:count > 0)<cr>
  noremap <buffer> <silent> <BS> <cmd>nohlsearch<CR>
enddef

augroup vimrc
  autocmd FileType dir CustomizeMappings()
augroup END
