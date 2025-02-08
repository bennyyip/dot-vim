vim9script

noremap <buffer><F8> :AsyncQf cmake --build .build --parallel<CR>
noremap <buffer><F9> :Sh .build/main<CR>

b:ale_fix_on_save = 1

g:Harpoon('m', 'CMakeLists.txt')
