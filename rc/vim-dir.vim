vim9script
g:dir_columns = "name"
g:dir_show_hidden = v:false

nmap -  :<C-u>Dir %:p:h<CR>

def CustomizeMappings()
  # Customize key mappings here
  nmap <buffer> gg 4G
enddef

augroup vimrc
  autocmd FileType dir CustomizeMappings()
augroup END

