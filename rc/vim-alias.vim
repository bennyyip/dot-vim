func Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc
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
" Alias Help help
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


Alias -range     il   ilist\ /\v/<left><c-r>=Eatchar("\ ")<cr>
Alias -range     dl   dlist\ //<left><c-r>=Eatchar("\ ")<cr>
