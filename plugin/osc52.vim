vim9script

if $SSH_CONNECTION == "" || !exists("*str2blob")
  finish
endif

def Copy(lines: list<string>)
  echoraw("\<Esc>]52;c;" ..
    base64_encode(str2blob(lines)) .. "\<Esc>\\")
enddef

def g:OSCYank(s: string)
  Copy([s])
enddef

xnoremap <C-c> <scriptcmd>Copy(getregion(getpos('v'), getpos('.'), { type: mode() }))<CR>y
