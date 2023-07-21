vim9script

g:EditorConfig_exclude_patterns = ['fugitive://.*']
augroup vimrc
autocmd FileType gitcommit let b:EditorConfig_disable = 1
augroup END
