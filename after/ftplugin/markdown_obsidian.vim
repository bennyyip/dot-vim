vim9script

if expand('%:p')->stridx(g:obsidian_vault->expand()) != 0
  finish
endif

setbufvar('', '&path', g:obsidian_vault .. '/**')

def GotoObsidian()
  const pos = getpos('.')
  # https://github.com/Vinzent03/obsidian-advanced-uri
  call os#Open($"obsidian://adv-uri?vault=Obsidian-Vault&filepath={expand('%:t')}&line={pos[1]}&column={pos[2]}")
enddef
nnoremap <buffer> <localleader>v <scriptcmd>GotoObsidian()<CR>

# [[url]] or [[url|description]]
def IncludeExpr(): string
  const cur = getpos('.')
  const head = searchpos("[[", 'bn')
  const tail = searchpos("]\\||", 'n')
  if cur[1] == head[0] && head[0] == tail[0] && head[1] < tail[1] && head[1] <= cur[2]
    const len = tail[1] - head[1] - 2
    const line = getline('.')
    const ret = strpart(line, head[1] + 1, len) .. '.md'
    return ret
  else
    return v:fname
  endif
enddef
setlocal includeexpr=IncludeExpr()
