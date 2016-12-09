" Go to Definition variable
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" 修改对C函数的补全快捷键，默认是CTRL + space，修改为ALT + ;
"let g:ycm_key_invoke_completion = '<M-;>'
" 回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
let g:ycm_key_list_select_completion = ['<C-n>', '<C-j>', '<Tab>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<C-k>', '<S-TAB>']

autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" error list
let g:ycm_always_populate_location_list = 1
" 禁止缓存匹配项，每次都重新生成匹配项
"let g:ycm_cache_omnifunc = 1
" 语法关键字补全
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_disable_for_files_larger_than_kb = 50000
let g:ycm_global_ycm_extra_conf = '~/.vim/config/.ycm_extra_conf.py'
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_show_diagnostics_ui = 0

let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'unite' : 1,
      \ 'text' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1,
      \ 'mundo': 1,
      \ 'fzf': 1,
      \ 'ctrlp' : 1
      \}
