vim9script
setlocal commentstring=//\ %s

setl cino+=g0,:0,j1,l1,N-s,t0,(0


#  (reference
# not call
nmap <localleader>f <scriptcmd>g:CocLocations("ccls", "textDocument/references", {"excludeRole": 32})<cr>
# macro
nmap <localleader>M <scriptcmd>g:CocLocations("ccls", "textDocument/references", {"role": 64})<cr>
# read
nmap <localleader>r <scriptcmd>g:CocLocations("ccls", "textDocument/references", {"role": 8})<cr>
# write
nmap <localleader>w <scriptcmd>g:CocLocations("ccls", "textDocument/references", {"role": 16})<cr>
# x (xref)
# bases of up to 3 levels
nmap <localleader>b <scriptcmd>g:CocLocations("ccls", "$ccls/inheritance", {})<cr>
nmap <localleader>B <scriptcmd>g:CocLocations("ccls", "$ccls/inheritance", {"levels": 3})<cr>
# derived of up to 3 levels
nmap <localleader>d <scriptcmd>g:CocLocations("ccls", "$ccls/inheritance", {"derived": v:true})<cr>
# derived of up to 3 levels
nmap <localleader>D <scriptcmd>g:CocLocations("ccls", "$ccls/inheritance", {"derived": v:true, "levels": 3})<cr>
# caller
nmap <localleader>c <scriptcmd>g:CocLocations("ccls", "$ccls/call")<cr>
# callee
nmap <localleader>C <scriptcmd>g:CocLocations("ccls", "$ccls/call", {"callee": v:true})<cr>
# member
nmap <localleader>m <scriptcmd>g:CocLocations("ccls", "$ccls/member")<cr>
nmap <localleader>t <scriptcmd>MarkPush()<cr>:call CocAction("jumpTypeDefinition")<cr>
