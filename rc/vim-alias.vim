let g:cmdalias_cmdprefixes = g:cmdalias_cmdprefixes->add('F5')

Alias sc   Scope
Alias scf  ScopeFile
Alias dotf ScopeFile\ ~/dotfiles<CR>
Alias gbl  Git\ blame
Alias gi   Git
Alias cm   Compiler
Alias lcm  LCompiler
Alias qf   AsyncQf
Alias ve   verbose
Alias vf   vertical\ sfind
" Alias Help help
Alias h vertical\ help
Alias H vertical\ help
Alias Wa   wa
Alias Wq   wq
Alias W    w
Alias Qa   qa
Alias Q    q
Alias tl   Tlist
Alias ghq  Ghq
Alias gp   Gpush
Alias f    find
Alias F    find
Alias t    Term
Alias T    Term
Alias f5   F5
Alias mv   RenameI
Alias zlr  ZellijRun
Alias zlrf ZellijRunFloat
Alias fmt  Fmt
Alias zen  Goyo
Alias tdb  Termdebug\ %<


Alias -range     il   ilist\ /\v/<left><c-r>=utils#Eatchar("\ ")<cr>
Alias -range     dl   dlist\ //<left><c-r>=utils#Eatchar("\ ")<cr>
