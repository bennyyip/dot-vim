vim9script

import autoload "../autoload/utils.vim"
import autoload "../autoload/os.vim"

# Reverse {{{1
command! -bar -range=% Reverse :<line1>,<line2>global/^/m <line1>-1<bar>nohl
# ChineseCount {{{1
function ChineseCount() range
  let save = @z
  silent exec 'normal! gv"zy'
  let text = @z
  let @z = save
  silent exec 'normal! gv'
  let cc = 0
  for char in split(text, '\zs')
    if char2nr(char) >= 0x2000
      let cc += 1
    endif
  endfor
  echo "Count of Chinese charasters is:"
  echo cc
endfunc

vnoremap <F2> :call <SID>ChineseCount()<cr>
# A {{{1
command! A call utils.A('e')
command! AV call utils.A('botright vertical split')
# PX: chmod +x {{{1
command! PX if !empty(expand('%'))
      \|   write
      \|   call system('chmod +x ' .. expand('%'))
      \|   silent e
      \| else
      \|   echohl WarningMsg
      \|   echo 'Save the file first'
      \|   echohl None
      \| endif
# RFC {{{1
command! -bar -count=0 RFC     :e /usr/share/doc/rfc/txt/rfc<count>.txt|setl ro noma
# Join {{{1
command! -nargs=1 -range=% -bang Join :<line1>,<line2>call utils.Lilydjwg_join(<q-args>, "<bang>")
command! -nargs=0 Split feedkeys(':%s``\r`g<left><left><left><left><left>')
# Quote {{{1
command! -bang -nargs=? -range=% Quote :<line1>,<line2>call utils.Quote(<q-args>, "<bang>")

command! -bang -nargs=? -range=% StrArray utils.StrArray(<line1>, <line2>)
# Ghq {{{1
def GhqComplete(A: string, ...args: list<any>): string
  const projs =  globpath(expand('~/ghq/github.com'), '*/*', 0, 1)
    ->map((k, x) => substitute(x, '^.*[/\\]\ze[^/\\]*[/\\]', '', ''))
  return projs->join("\n")
enddef
command! -nargs=1 -complete=custom,GhqComplete Ghq execute 'edit ' .. expand('~/ghq/github.com/') .. <q-args>
# FollowLink {{{1
command! -nargs=0 FollowLink utils.FollowLink()
# SetTabWidth {{{1
command! -nargs=0 SetTabWidth2 call utils.SetTabWidth(2, true)
command! -nargs=0 SetTabWidth4 call utils.SetTabWidth(4, true)
command! -nargs=0 SetHardTabWidth2 call utils.SetTabWidth(2, false, 0)
command! -nargs=0 SetHardTabWidth4 call utils.SetTabWidth(4, false, 0)
command! -nargs=0 SetHardTabWidth8 call utils.SetTabWidth(8, false, 0)
# SaveSession and LoadSession {{{1
if !isdirectory($'{$VIMSTATE}/session')
  mkdir($'{$VIMSTATE}/session', "p")
endif
command! -nargs=1 -complete=custom,utils.SessionComplete SaveSession :exe $'mksession! {$VIMSTATE}/session/<args>'
command! -nargs=1 -complete=custom,utils.SessionComplete LoadSession :%bd <bar> exe $'so {$VIMSTATE}/session/<args>'
# GotoDef {{{1
import autoload 'gotodef.vim'
command! -bang -nargs=1 -complete=command Command gotodef.DoGotoDef("command", <f-args>)
command! -bang -nargs=1 -complete=custom,gotodef.MapComplete  Map  gotodef.DoGotoDef("map", <f-args>)
command! -bang -nargs=1 -complete=custom,gotodef.NmapComplete Imap gotodef.DoGotoDef("imap", <f-args>)
command! -bang -nargs=1 -complete=custom,gotodef.ImapComplete Nmap gotodef.DoGotoDef("nmap", <f-args>)
command! -bang -nargs=1 -complete=custom,gotodef.CmapComplete Cmap gotodef.DoGotoDef("cmap", <f-args>)
command! -bang -nargs=1 -complete=custom,gotodef.XmapComplete Xmap gotodef.DoGotoDef("xmap", <f-args>)
command! -bang -nargs=1 -complete=custom,gotodef.XmapComplete Vmap gotodef.DoGotoDef("xmap", <f-args>)

# }}}
# Zen {{{1
# command! Zen silent! normal! <C-W>v<C-W>h:enew<CR>70<C-W><lt><C-W><C-W>
# Share{{{1
import autoload "share.vim"
command! -range=% -nargs=? -complete=custom,share.Complete Share share.Paste(<q-args>, <line1>, <line2>)
# Search: literal search {{{1
command! -nargs=? Search {
  var arg = <q-args>
  if <q-args> == ''
    arg = input("Search: ")
  endif
  setreg('/', $'\V{escape(arg, '\\')}')
  normal! n
}
# }}}
# Bonly {{{1
command! Bonly :%bd<BAR>:e %%
# DiffOrig {{{1
command! DiffOrig vert new | set bt=nofile | r ++edit %%
      \ | :0d _ | diffthis | wincmd p | diffthis
# Bsearch {{{1
def Bsearch(input: string = "")
  var target = input
  if target == ''
    target = inputdialog("Enter string to search: ")
    if target == null || target == ""
      return
    endif
  endif

  target = target->trim()

  var left = 1
  var right = line("$")

  while left <= right
    const mid = (left + right) / 2
    const mid_value = getline(mid)->trim()

    if mid_value < target
      left = mid + 1
    elseif mid_value > target
      right = mid - 1
    else
      # Exact match found
      execute $":{mid}"
      normal! zz
      return
    endif
  endwhile

  execute $":{left}"
  normal! zz
enddef


command! -nargs=? Bsearch call Bsearch(<q-args>)
# }}}
# Lab {{{1
# F4 repeat last command
nnoremap <silent> <F4> <cmd>execute getreg(':')<CR>
# F5 to F8 : Execute command and save to register `a` to `d`. Press F5 to repeat.
def F(reg: string, cmd: string)
  if cmd == ''
    if getreg(reg) == ''
      echo "slot is empty"
    else
      echo getreg(reg)
    endif
    return
  endif

  execute cmd
  setreg(reg, cmd)
enddef
command! -nargs=? -complete=command F5 F('a', <q-args>)
command! -nargs=? -complete=command F6 F('b', <q-args>)
command! -nargs=? -complete=command F7 F('c', <q-args>)
command! -nargs=? -complete=command F8 F('d', <q-args>)
nnoremap <silent> <F5> <cmd>execute getreg('a')<CR>
nnoremap <silent> <F6> <cmd>execute getreg('b')<CR>
nnoremap <silent> <F7> <cmd>execute getreg('c')<CR>
nnoremap <silent> <F8> <cmd>execute getreg('d')<CR>
inoremap <silent> <F5> <ESC><cmd>execute getreg('a')<CR>
inoremap <silent> <F6> <ESC><cmd>execute getreg('b')<CR>
inoremap <silent> <F7> <ESC><cmd>execute getreg('c')<CR>
inoremap <silent> <F8> <ESC><cmd>execute getreg('d')<CR>

command! -nargs=0 CopyLastCommand legacy let @+ = @:
command! -nargs=+ -complete=command CopyCommandOutput redir @+ | <args> | redir END


command! StartProfile {
    profile start profile.log
    profile func *
    profile file *
}
command! StopProfile {
    profile pause
    noautocmd qall!
}


command! ToggleVerbose {
  if !&verbose
    set verbosefile=~/.log/vim/verbose.log
    set verbose=15
  else
    set verbose=0
    set verbosefile=
  endif
}

# 设置成 Linux 下适用的格式
command Lin setl ff=unix fenc=utf8 nobomb eol
# }}}

import autoload 'hlblink.vim'
command BlinkLine hlblink.Line()

command! Ctags utils.GenCtags()

command! -nargs=? -complete=file Rename os.RenameInteractive(<q-args>)
command! -bang Delete os.Delete(<q-bang> == '!')
if !has('win32')
    command! SudoWrite w !sudo tee "%" >/dev/null
endif

command! -range=% LLM {
  const f = g:scratchpad_path .. '/llm.md'

  var lines = ['```' .. &ft]
  lines->extend(getline(<line1>, <line2>))
  lines->add('```')

  writefile(lines, f)
  execute $":split + {f}"
  feedkeys('o')
}

command! -nargs=? -complete=file Yazi os.Yazi(<q-args> == '' ? '%' : <q-args>)

command! -nargs=1 Doc call os.Doc(<q-args>)

command! Nofile enew|set buftype=nofile

command! OdinRoot {
  const root = system('odin root')
  execute $":edit {root}"
}

def Watch(cmd: string, clear_only: bool)
  if exists('#ben_watch')
    augroup ben_watch
      autocmd!
    augroup END
    augroup! ben_watch
  endif

  if cmd == "" || clear_only
    return
  endif
  autocmd_add([{
    pattern: expand("%:p"),
    event: "BufWritePost",
    cmd: cmd,
    group: "ben_watch",
  }])
  execute cmd
enddef

command! -bang -nargs=? Watch Watch(<q-args>, <bang>0)
# vim:fdm=marker:ft=vim
