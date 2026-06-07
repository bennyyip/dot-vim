vim9script


command! -buffer Asm AsyncQf clang -S -masm=intel % -o  %<.S
