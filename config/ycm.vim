let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/config/.ycm_extra_conf.py'

"let g:ycm_collect_identifiers_from_tags_files = 1 
"let g:ycm_seed_identifiers_with_syntax = 1
"let g:ycm_min_num_of_chars_for_completion = 0
"let g:ycm_auto_trigger = 0
"let g:ycm_show_diagnostics_ui = 0
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:ycm_filetype_whitelist = { 
"    \ 'c': 1 ,
"    \ 'cpp': 1,
"    \ 'python': 1 
"    \}
nnoremap <leader>gd :YcmCompleter GoTo<CR>


autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" 禁止缓存匹配项，每次都重新生成匹配项  
let g:ycm_cache_omnifunc = 1  
" 语法关键字补全              
let g:ycm_seed_identifiers_with_syntax=1  
" 修改对C函数的补全快捷键，默认是CTRL + space，修改为ALT + ;  
let g:ycm_key_invoke_completion = '<M-;>'  
" 回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
