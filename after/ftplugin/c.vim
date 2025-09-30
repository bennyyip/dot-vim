vim9script
setlocal commentstring=//\ %s

setl cino+=g0,:0,j1,l1,N-s,t0,(0
set foldnestmax=1

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
