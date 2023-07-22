vim9script

g:EditorConfig_exclude_patterns = ['fugitive://.*']
augroup vimrc
autocmd FileType gitcommit b:EditorConfig_disable = 1
augroup END
