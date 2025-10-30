vim9script

import autoload "term.vim"

command! -bang TermToggle term.ToggleTerminal("", <q-bang> == '!')
command! TermShow         term.ShowTerminal(<q-bang> == '!')
command! TermDelete       term.DeleteTerminal()

command! -nargs=+ -complete=shellcmdline Term term.SendLine(<q-args>)
command! TermCD term.SendLine("cd", getcwd())

term.TerminalMap("<F12>", ":TermToggle<CR>")
term.TerminalMap("<F11>", ":TermToggle!<CR>")

set termwinkey=<C-F>
tnoremap <F1> <C-F>N
xnoremap <expr> <c-q> term.Send()
nnoremap <expr> <c-q> term.Send()
nnoremap <expr> <c-q><c-q> term.Send() .. '_'
# imap <c-q> <ESC><c-q><c-q>a
# repeat
nnoremap <localleader>t <cmd>update<BAR>Term<UP><CR>

if $W64DEVKIT != ""
  # busybox ash source $ENV
  g:term_opts = {
    env: {
      ENV: $"{$HOME}/.profile"
    }
  }
  g:term_shell = 'sh'
endif
