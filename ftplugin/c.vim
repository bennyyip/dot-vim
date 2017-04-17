nnoremap <leader>R :w<CR>:AsyncRun clang -std=c99 % -o /tmp/%< && /tmp/%< <CR>

" rhysd/vim-clang-format
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11" }

" map to <Leader>cf in C++ code
nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
vnoremap <buffer><Leader>cf :ClangFormat<CR>
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

