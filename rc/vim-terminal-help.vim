vim9script
if has('win32')
    g:terminal_shell = 'pwsh'
else
    g:terminal_shell = &shell
endif

g:terminal_cwd = 2
g:terminal_list = 0
g:terminal_close = 1
