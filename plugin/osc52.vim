vim9script

if $SSH_CONNECTION == ""
  finish
endif
if !exists("*str2blob")
  packadd oscyank
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

if !getcompletion('osc52', 'packadd')->empty()
  g:osc52_no_da1 = 1
  g:osc52_force_avail = 1
  packadd osc52
  set clipmethod^=osc52
endif
