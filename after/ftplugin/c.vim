vim9script
setlocal commentstring=//\ %s

augroup formatprgsC
  autocmd! * <buffer>
  if exists('##ShellFilterPost')
    autocmd ShellFilterPost <buffer> if v:shell_error | execute 'echom "shell filter returned error "..v:shell_error..", undoing changes"' | undo | endif
  endif
augroup END


setl cino+=g0,:0,j1,l1,N-s,t0,(0
set foldnestmax=1

setlocal formatprg=clang-format

# not call
nmap <buffer> <localleader>f <scriptcmd>g:LspFindLocations('ccls', false, "textDocument/references", {"excludeRole": 32})<cr>
# macro
nmap <buffer> <localleader>M <scriptcmd>g:LspFindLocations('ccls', false, "textDocument/references", {"role": 64})<cr>
# read
nmap <buffer> <localleader>r <scriptcmd>g:LspFindLocations('ccls', false, "textDocument/references", {"role": 8})<cr>
# write
nmap <buffer> <localleader>w <scriptcmd>g:LspFindLocations('ccls', false, "textDocument/references", {"role": 16})<cr>
# x (xref)
# bases of up to 3 levels
nmap <buffer> <localleader>b <scriptcmd>g:LspFindLocations('ccls', false, "$ccls/inheritance", {})<cr>
nmap <buffer> <localleader>B <scriptcmd>g:LspFindLocations('ccls', false, "$ccls/inheritance", {"levels": 3})<cr>
# derived of up to 3 levels
nmap <buffer> <localleader>d <scriptcmd>g:LspFindLocations('ccls', false, "$ccls/inheritance", {"derived": v:true})<cr>
nmap <buffer> <localleader>D <scriptcmd>g:LspFindLocations('ccls', false, "$ccls/inheritance", {"derived": v:true, "levels": 3})<cr>
# caller
nmap <buffer> <localleader>c <scriptcmd>g:LspFindLocations('ccls', false, "$ccls/call")<cr>
# callee
nmap <buffer> <localleader>C <scriptcmd>g:LspFindLocations('ccls', false, "$ccls/call", {"callee": v:true})<cr>
# member
nmap <buffer> <localleader>m <scriptcmd>g:LspFindLocations('ccls', false, "$ccls/member")<cr>

# nmap <silent> <2-LeftMouse> <cmd>call MarkPush()<cr>:call CocAction("jumpDefinition")<cr>
# nmap <localleader>t <scriptcmd>MarkPush()<cr>:call CocAction("jumpTypeDefinition")<cr>

# #  (reference
# # not call
# nmap <localleader>f <scriptcmd>g:CocLocations("ccls", "textDocument/references", {"excludeRole": 32})<cr>
# # macro
# nmap <localleader>M <scriptcmd>g:CocLocations("ccls", "textDocument/references", {"role": 64})<cr>
# # read
# nmap <localleader>r <scriptcmd>g:CocLocations("ccls", "textDocument/references", {"role": 8})<cr>
# # write
# nmap <localleader>w <scriptcmd>g:CocLocations("ccls", "textDocument/references", {"role": 16})<cr>
# # x (xref)
# # bases of up to 3 levels
# nmap <localleader>b <scriptcmd>g:CocLocations("ccls", "$ccls/inheritance", {})<cr>
# nmap <localleader>B <scriptcmd>g:CocLocations("ccls", "$ccls/inheritance", {"levels": 3})<cr>
# # derived of up to 3 levels
# nmap <localleader>d <scriptcmd>g:CocLocations("ccls", "$ccls/inheritance", {"derived": v:true})<cr>
# # derived of up to 3 levels
# nmap <localleader>D <scriptcmd>g:CocLocations("ccls", "$ccls/inheritance", {"derived": v:true, "levels": 3})<cr>
# # caller
# nmap <localleader>c <scriptcmd>g:CocLocations("ccls", "$ccls/call")<cr>
# # callee
# nmap <localleader>C <scriptcmd>g:CocLocations("ccls", "$ccls/call", {"callee": v:true})<cr>
# # member
# nmap <localleader>m <scriptcmd>g:CocLocations("ccls", "$ccls/member")<cr>
