" octol/vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_simple_template_highlight = 0
"slow
let g:cpp_experimental_template_highlight = 1

nnoremap <leader>R :w<CR>:AsyncRun clang++ -std=c++14 % -o /tmp/%< && /tmp/%< <CR>

" rhysd/vim-clang-format
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11" }

nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
vnoremap <buffer><Leader>cf :ClangFormat<CR>

" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

