noremap <buffer><F8> :AsyncQf cmake --build .build --parallel<CR>
noremap <buffer><F9> :Sh .build/main<CR>

let b:ale_fix_on_save = 1
