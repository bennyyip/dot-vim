" octol/vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_simple_template_highlight = 0
"slow
let g:cpp_experimental_template_highlight = 1


au FileType cpp nnoremap <leader>R :w<CR>:AsyncRun clang++ -std=c++14 % -o /tmp/%< && /tmp/%< <CR>
au FileType c nnoremap <leader>R :w<CR>:AsyncRun clang -std=c99 % -o /tmp/%< && /tmp/%< <CR>

" rhysd/vim-clang-format
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11" }
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>W :<C-u>ClangFormat<CR>:w<CR>
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

command! GenClangComplete AsyncRun make clean && make CC='~/.vim/bin/cc_args.py gcc'
