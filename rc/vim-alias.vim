func Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc

Alias sc   Scope
Alias gbl  Git\ blame
Alias gi   Git
Alias cm   Compiler
Alias lcm  LCompiler
Alias qf   AsyncQf
Alias ve   verbose
Alias Help help
Alias Wa   wa
Alias Wq   wq
Alias W    w
Alias Qa   qa
Alias Q    q
Alias tl   Tlist
Alias ghq  Ghq
Alias f    find
Alias F    find
Alias t    Term
Alias T    Term
Alias f5   F5
Alias -range     il   ilist\ /\v/<left><c-r>=Eatchar("\ ")<cr>
Alias -range     dl   dlist\ //<left><c-r>=Eatchar("\ ")<cr>
