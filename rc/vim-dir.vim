vim9script
import autoload 'dir/action.vim'

g:dir_columns = "name"
g:dir_show_hidden = v:false
g:dir_invert_split = v:true

nmap -  :<C-u>Dir %:p:h<CR>


def CustomizeMappings()
  # Customize key mappings here
  nmap <buffer> gg 4G
  noremap <buffer> < <scriptcmd>action.WidenView(v:count > 0)<cr>
  noremap <buffer> > <scriptcmd>action.ShrinkView(v:count > 0)<cr>
  noremap <buffer> <silent> <BS> <cmd>nohlsearch<CR>
  if plugpac#HasPlugin("LeaderF")
    nmap <buffer> <leader>ff <leader>.
    nnoremap <buffer> <leader>.  <scriptcmd>execute($'Leaderf file {b:dir_cwd}')<cr>
  endif
enddef

augroup vimrc
  autocmd FileType dir CustomizeMappings()
augroup END
