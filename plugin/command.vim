vim9script

import autoload "../autoload/utils.vim"
import autoload "../autoload/term.vim"

# Reverse [[[1
command! -bar -range=% Reverse :<line1>,<line2>global/^/m <line1>-1<bar>nohl
# ChineseCount [[[1
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

vnoremap <F7> :call <SID>ChineseCount()<cr>
# A [[[1
command! A call utils.A('e')
command! AV call utils.A('botright vertical split')
# PX: chmod +x [[[1
command! PX if !empty(expand('%'))
      \|   write
      \|   call system('chmod +x ' .. expand('%'))
      \|   silent e
      \| else
      \|   echohl WarningMsg
      \|   echo 'Save the file first'
      \|   echohl None
      \| endif
# RFC [[[1
command! -bar -count=0 RFC     :e /usr/share/doc/rfc/txt/rfc<count>.txt|setl ro noma
# Join [[[1
command! -nargs=1 -range=% -bang Join :<line1>,<line2>call utils.Lilydjwg_join(<q-args>, "<bang>")
# Quote [[[1
command! -bang -nargs=? -range=% Quote :<line1>,<line2>call utils.Quote(<q-args>, "<bang>")

command! -bang -nargs=? -range=% StrArray utils.StrArray(<line1>, <line2>)
# Ghq [[[1
def GhqList(A: string, ...args: list<any>): list<string>
  const projs =  globpath(expand('~/ghq/github.com'), '*/*', 0, 1)
    ->map((k, x) => substitute(x, '^.*[/\\]\ze[^/\\]*[/\\]', '', ''))
  return projs->utils.Matchfuzzy(A)
enddef
command! -nargs=1 -complete=customlist,GhqList Ghq execute 'edit ' .. expand('~/ghq/github.com/') .. <q-args>
# FollowLink [[[1
command! -nargs=0 FollowLink utils.FollowLink()
# SetTabWidth [[[1
command! -nargs=0 SetTabWidth2 call utils.SetTabWidth(2, true)
command! -nargs=0 SetTabWidth4 call utils.SetTabWidth(4, true)
command! -nargs=0 SetHardTabWidth2 call utils.SetTabWidth(2, false, 0)
command! -nargs=0 SetHardTabWidth4 call utils.SetTabWidth(4, false, 0)
command! -nargs=0 SetHardTabWidth8 call utils.SetTabWidth(8, false, 0)
# SaveSession and LoadSession [[[1
if !isdirectory($'{$VIMSTATE}/session')
  mkdir($'{$VIMSTATE}/session', "p")
endif
command! -nargs=1 -complete=custom,utils.SessionComplete SaveSession :exe $'mksession! {$VIMSTATE}/session/<args>'
command! -nargs=1 -complete=custom,utils.SessionComplete LoadSession :%bd <bar> exe $'so {$VIMSTATE}/session/<args>'
# GotoDef [[[1
import autoload 'gotodef.vim'
command! -bang -nargs=1 -complete=command Command gotodef.DoGotoDef("command", <f-args>)
command! -bang -nargs=1 -complete=customlist,gotodef.MapComplete  Map  gotodef.DoGotoDef("map", <f-args>)
command! -bang -nargs=1 -complete=customlist,gotodef.NmapComplete Imap gotodef.DoGotoDef("imap", <f-args>)
command! -bang -nargs=1 -complete=customlist,gotodef.ImapComplete Nmap gotodef.DoGotoDef("nmap", <f-args>)
command! -bang -nargs=1 -complete=customlist,gotodef.CmapComplete Cmap gotodef.DoGotoDef("cmap", <f-args>)
command! -bang -nargs=1 -complete=customlist,gotodef.XmapComplete Xmap gotodef.DoGotoDef("xmap", <f-args>)
command! -bang -nargs=1 -complete=customlist,gotodef.XmapComplete Vmap gotodef.DoGotoDef("xmap", <f-args>)

# ]]]
# Zen [[[1
# command! Zen silent! normal! <C-W>v<C-W>h:enew<CR>70<C-W><lt><C-W><C-W>
# Share[[[1
import autoload "share.vim"
command! -range=% -nargs=? -complete=custom,share.Complete Share share.Paste(<q-args>, <line1>, <line2>)
# Search: literal search [[[1
command! -nargs=? Search {
  var arg = <q-args>
  if <q-args> == ''
    arg = input("Search: ")
  endif
  setreg('/', $'\V{escape(arg, '\\')}')
  normal! n
}
# Inspect: syntax group names under cursor [[[1
command! Inspect :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
# ]]]
# Bonly [[[1
command! Bonly :%bd<BAR>:e %%
# DiffOrig [[[1
command DiffOrig vert new | set bt=nofile | r ++edit %%
      \ | :0d _ | diffthis | wincmd p | diffthis
# Lab [[[1
#   设置成 Linux 下适用的格式
command Lin setl ff=unix fenc=utf8 nobomb eol
# F5: Execute command and save to register `c`. Press F5 to repeat. [[[1
def F5(cmd: string)
  execute cmd
  setreg('c', cmd)
enddef
command! -nargs=+ -complete=command F5 F5(<q-args>)
nnoremap <silent> <F5> <cmd>execute getreg('c')<CR>
inoremap <silent> <F5> <ESC><cmd>execute getreg('c')<CR>
nnoremap <silent> <F4> <cmd>execute getreg(':')<CR>
# Term: send comamnd to terminal
command! -nargs=+ -complete=shellcmdline Term term.SendLine(<q-args>)
# ]]]
# vim:fdm=marker:fmr=[[[,]]]:ft=vim
