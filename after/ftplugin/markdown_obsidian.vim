vim9script

if expand('%:p')->stridx(g:obsidian_vault->expand()) != 0
  finish
endif

import autoload '../../autoload/yb.vim'

SetHardTabWidth4

def GotoObsidian()
  const pos = getpos('.')
  # https://github.com/Vinzent03/obsidian-advanced-uri
  call os#Open($"obsidian://adv-uri?vault=Obsidian-Vault&filepath={expand('%:t')}&line={pos[1]}&column={pos[2]}")
enddef
nnoremap <buffer> <localleader>o <scriptcmd>GotoObsidian()<CR>

nnoremap <buffer> gf <scriptcmd>yb.JumpToWikilink()<CR>
