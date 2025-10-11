vim9script

import autoload 'qf.vim'
set quickfixtextfunc=qf.QuickFixText

nnoremap <leader>q <scriptcmd>qf.ToggleQF()<CR>
nnoremap <leader>l <scriptcmd>qf.ToggleLoc()<CR>
