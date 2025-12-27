vim9script

import autoload "term.vim"

command! -bang TermToggle term.ToggleTerminal("", <q-bang> == '!')
command! TermShow         term.ShowTerminal(<q-bang> == '!')
command! TermDelete       term.DeleteTerminal()

command! -nargs=+ -complete=shellcmdline TermSend term.SendLine(<q-args>)
command! TermCD term.SendLine("cd", getcwd())

command! -nargs=? -complete=shellcmdline Term term.Run(<q-args> ?? &shell, <q-mods> ?? window#BotRight())
noremap <leader>; :Term<space>
command! Cbuffer cbuffer<BAR>copen

term.TerminalMap("<F12>", ":TermToggle<CR>")
term.TerminalMap("<F11>", ":TermToggle!<CR>")

set termwinkey=<C-F>
tnoremap <F1> <C-F>N
xnoremap <expr> <c-q> term.Send()
nnoremap <expr> <c-q> term.Send()
nnoremap <expr> <c-q><c-q> term.Send() .. '_'
# imap <c-q> <ESC><c-q><c-q>a
# repeat
# nnoremap <localleader>t <cmd>update<BAR>Term<UP><CR>

tnoremap <m-b> <c-left>
tnoremap <m-f> <c-right>

def TermMappings()
    nnoremap <buffer> <C-r> <scriptcmd>term.ReRun()<CR>
    nnoremap <buffer> <F5> <scriptcmd>term.ReRun()<CR>
enddef
augroup Terminal
    au!
    au TerminalWinOpen * TermMappings()
    au TerminalOpen * ++nested {
        var buf = expand("<afile>")->escape('#%[ ')
        exe $"au BufWinEnter {buf} ++once TermMappings()"
    }
augroup END


if $W64DEVKIT != ""
  # busybox ash source $ENV
  g:term_opts = {
    env: {
      ENV: $"{$HOME}/.profile"
    }
  }
  g:term_shell = 'sh'
endif
