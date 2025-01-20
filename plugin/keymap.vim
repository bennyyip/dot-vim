vim9script
import autoload 'utils.vim'
import autoload 'text.vim'
import autoload 'buf.vim'
const is_gvim = has('gui_running')
# fold [[[3
nmap z] zo]z
nmap z[ zo[z
nnoremap <leader><space> za
# correct spell [[[3
cabbrev Q q
cabbrev Qa qa
cabbrev W w
cabbrev Wq wq
cabbrev Wa wa
# cabbrev X x
cabbrev Help help
cabbrev ve verbose
cabbrev vec verbose<space>command
cabbrev veim verbose<space>imap
cabbrev venm verbose<space>nmap
cabbrev vem verbose<space>map
# syntax [[[3
nnoremap <leader>Si  :echo ben#syninfo()<cr>
# diff [[[3
nnoremap <silent><leader>di :windo diffthis<CR>
nnoremap <silent><leader>du :windo diffupdate<CR>
nnoremap <silent><leader>do :windo diffoff<CR>
# linewise partial staging in visual-mode.
xnoremap <c-p> :diffput<cr>
xnoremap <c-o> :diffget<cr>
# quickfix and loclist [[[3
nnoremap <silent>  <q :call quickfixed#older()<CR>
nnoremap <silent>  >q :call quickfixed#newer()<CR>
# nohl [[[3
# Use <backspace> to:
#   - redraw
#   - clear 'hlsearch'
#   - update the current diff (if any)
# Use {count}<backspace> to:
#   - reload (:edit) the current buffer
nnoremap <silent><expr> <backspace> (v:count > 0 ? ':<C-U>:call ben#save_change_marks()\|edit\|call ben#restore_change_marks()<CR>' : '')
      \ .. ':nohlsearch' .. (has('diff') ? '\|diffupdate' : '')
      \ .. '<CR>'
      # \ .. '<CR><C-L>'
nnoremap z. :call ben#save_change_marks()<Bar>w<Bar>call ben#restore_change_marks()<cr>z.
# window [[[1
# quick <C-w>
nnoremap ' <C-w>
nnoremap '' <C-w>w
# toogle window zoom
import autoload 'zoom.vim'
nnoremap <C-w><C-o> <scriptcmd>zoom.Toggle()<CR>
nmap <C-w>o <C-w><C-o>
nmap 'o <C-w><C-o>
# Toggle quickfix and loclist
def ToggleQF()
  if getwininfo()->filter('v:val.quickfix')->len() > 0
    cclose
  else
    copen
  endif
enddef
def ToggleLoc()
  if getwininfo()->filter('v:val.loclist')->len() > 0
    lclose
  else
    lopen
  endif
enddef
nnoremap <leader>q <scriptcmd>ToggleQF()<CR>
nnoremap <leader>l <scriptcmd>ToggleLoc()<CR>
# edit [[[1
# swap <c-n> and <c-x><c-n>
inoremap <expr> <C-N> pumvisible() ?  "\<C-N>" : "\<C-X>\<C-N>"
inoremap <C-X><C-N> <C-N>

# inoremap "<space><space> ""<ESC>i
# inoremap '<space><space> ''<ESC>i
# inoremap (<space><space> ()<ESC>i
# inoremap [<space><space> []<ESC>i
# inoremap <<space><space> <><ESC>i
# inoremap {<space><space> {<space><space>}<ESC>hi
# inoremap (<CR> (<CR>)<Esc>O
inoremap {<CR> {<CR>}<Esc>O
inoremap [<CR> [<CR>]<Esc>O
# inoremap (; (<space><space>);<Esc>hhi
# inoremap (, (<space><space>),<Esc>hhi
inoremap {; {<space><space>};<Esc>hhi
# inoremap {, {<space><space>},<Esc>hhi
inoremap [; [<space><space>];<Esc>hhi
inoremap [, [<space><space>],<Esc>hhi
inoremap <Plug>(meta-o) <C-O>o
inoremap <Plug>(meta-O) <C-O>O
# script helper
inoreabbrev <expr> #!! "#!/usr/bin/env" .. (empty(&filetype) ? '' : ' ' .. &filetype)
inoreabbrev <expr> #!s "#!/bin/bash -e"
# get output from python
imap <C-R>c <esc>:let @a=""<CR>:let @a = execute( "py3 print()")<left><left><left>
# time
inoremap <silent> <C-G><C-T> <C-R>=repeat(complete(col('.'),map(["%Y-%m-%d %H:%M:%S","%a, %d %b %Y %H:%M:%S %z","%Y %b %d","%d-%b-%y","%a %b %d %T %Z %Y"],'strftime(v:val)')+[localtime()]),0)<CR>
# 26 simple text objects
# ----------------------
# i_ i. i: i, i; i| i/ i\ i* i+ i- i# i<tab>
# a_ a. a: a, a; a| a/ a\ a* a+ a- a# a<tab>
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#', '<tab>' ]
    execute $"xnoremap <silent> i{char} <esc><scriptcmd>text.Obj('{char}', 1)<CR>"
    execute $"xnoremap <silent> a{char} <esc><scriptcmd>text.Obj('{char}', 0)<CR>"
    execute $"onoremap <silent> i{char} :normal vi{char}<CR>"
    execute $"onoremap <silent> a{char} :normal va{char}<CR>"
endfor
# indent text object
onoremap <silent>ii <scriptcmd>text.ObjIndent(v:true)<CR>
onoremap <silent>ai <scriptcmd>text.ObjIndent(v:false)<CR>
xnoremap <silent>ii <esc><scriptcmd>text.ObjIndent(v:true)<CR>
xnoremap <silent>ai <esc><scriptcmd>text.ObjIndent(v:false)<CR>

onoremap <silent>ic <scriptcmd>text.ObjComment(v:true)<CR>
onoremap <silent>ac <scriptcmd>text.ObjComment(v:false)<CR>
xnoremap <silent>ic <esc><scriptcmd>text.ObjComment(v:true)<CR>
xnoremap <silent>ac <esc><scriptcmd>text.ObjComment(v:false)<CR>
xnoremap <silent> in <esc><scriptcmd>text.ObjNumber()<CR>
onoremap <silent> in :<C-u>normal vin<CR>

# line text object
xnoremap <silent> il <esc><scriptcmd>text.ObjLine(1)<CR>
onoremap <silent> il :<C-u>normal vil<CR>
xnoremap <silent> al <esc><scriptcmd>text.ObjLine(0)<CR>
onoremap <silent> al :<C-u>normal val<CR>

# yank and paste [[[1
cnoremap <C-v>         <C-R>+
# inoremap <silent><C-v> <C-O>:set paste<CR><C-R>+<C-O>:set nopaste<CR>
inoremap <silent><C-v> <C-R><C-o>+
inoremap <silent><C-z> <ESC>u
xnoremap <silent>Y     "+y
xnoremap <silent><C-c> "+y
nnoremap Y   y$
xnoremap x  "_d
xnoremap P  "0p
# select what I just pasted
nnoremap <expr> gp '`[' .. strpart(getregtype(), 0, 1) .. '`]'
# copy entire file contents (to gui-clipboard if available)
nnoremap yY :let b:winview=winsaveview()<bar>exe 'keepjumps keepmarks norm ggVG' .. (has('clipboard')?'"+y':'y')<bar>call winrestview(b:winview)<cr>
# vimrc [[[1
nnoremap <silent><leader>fed :e $VIMRC<CR>
nnoremap <silent><leader>fee :source $VIMRC<CR>
# source vimscript (operator)
def SourceVim(...args: list<any>): string
    if len(args) == 0
        &opfunc = matchstr(expand('<stack>'), '[^. ]*\ze[')
        return 'g@'
    endif
    if getline(1) =~ '^vim9script$'
        vim9cmd :'[,']source
    else
        :'[,']source
    endif
    return ''
enddef
nnoremap <silent> <expr> yr SourceVim()
nnoremap <silent> <expr> yrr SourceVim() .. '_'
xnoremap <silent> <expr> <space>v SourceVim()
# visual [[[1
# keep selection when indent line in visual mode
xnoremap <expr> > v:count > 0 ? ">" : ">gv"
xnoremap <expr> < v:count > 0 ? "<" : "<gv"
# niceblock
xnoremap <expr> I (mode() =~# '[vV]' ? '<C-v>^o^I' : 'I')
xnoremap <expr> A (mode() =~# '[vV]' ? '<C-v>0o$A' : 'A')
# In visual block { and } navigate to the first/last line of paragraph,
# which is useful if followed by I or A.
def VisualBlockPara(cmd: string)
    if mode() == "\<C-V>"
        var target_row = getpos($"'{cmd}")[1]
        if getline(target_row) =~ "^\s*$"
            target_row += (cmd == "{" ? 1 : -1)
            if target_row == line('.')
                target_row = (cmd == "{" ? prevnonblank(target_row - 1)
                                         : nextnonblank(target_row + 1))
            endif
        endif
        if target_row > 0
            exe $":{target_row}"
        endif
    else
        exe $"normal! {cmd}"
    endif
enddef
xnoremap { <scriptcmd>VisualBlockPara("{")<CR>
xnoremap } <scriptcmd>VisualBlockPara("}")<CR>
# macro [[[1
# quick edit macro  | ["register]<leader>m
nnoremap <c-g>m  :<c-u><c-r><c-r>='let @' .. v:register .. ' = ' .. string(getreg(v:register))<cr><c-f><left>
nnoremap Q @q
xnoremap Q :normal @q<CR>
# repeat last command for each line of a visual selection
xnoremap . :normal .<CR>
# search and substitute [[[1
# quick substitute
xnoremap qs "zy:%s`<C-r>=$'\V{escape(getreg("z"), '/\\')}'->split("\n")->join('\n')<CR>``g<left><left>
nnoremap qs :%s`<C-R><C-W>``g<left><left>
xnoremap qS "zy:%S`<C-r>=$'\V{escape(getreg("z"), '/\\')}'->split("\n")->join('\n')<CR>``g<left><left>
nnoremap qS :%S`<C-R><C-W>``g<left><left>
nnoremap & n:&&<CR>
xnoremap & n:&&<CR>
# mark position before search
nnoremap / ms/
# search in selection
xnoremap / <ESC>/\%><c-r>=line("'<")-1<cr>l\%<<c-r>=line("'>")+1<cr>l<HOME>
# restore /
xnoremap g/ /

# Emacs C-s C-w like solution: hightlight in visual mode and then type * or #
# `cgn` to replace text
# https://vonheikemen.github.io/devlog/tools/how-to-survive-without-multiple-cursors-in-vim/
xnoremap * :<c-u> call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<c-u> call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
# SID means script local function; 'call' is optional in vim9script.
def VSetSearch(cmdtype: string)
  var temp = getreg('s') # 's' is some register
  norm! gv"sy
  setreg('/', '\V' .. substitute(escape(@s, cmdtype .. '\'), '\n', '\\n', 'g'))
  setreg('s', temp) # restore whatever was in 's'
enddef

nnoremap <silent> <leader>= <scriptcmd>utils.RemoveSpaces()<CR>
# file, buffer [[[1
nnoremap <leader>fs :w<CR>
nnoremap <silent> <leader>fy :call os#Yank(expand("%:t"))<CR>:echo "buffer filename copied"<CR>
nnoremap <silent> <leader>fP :call os#Yank(expand("%:p"))<CR>:echo "buffer path copied"<CR>
nnoremap cd :lcd %:p:h<bar>pwd<cr>
nnoremap cu :lcd ..<bar>pwd<cr>

nnoremap <silent><leader><tab> <c-6>
nnoremap gF :e <cfile><cr>
nnoremap gb :b<space>
nnoremap <C-G><C-G> <C-G>
# tab [[[1
nmap     T :tabnew<cr>
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>
def SwitchTab(i: number)
  if tabpagenr() == i
    tabprev
  else
    silent! execute $"tabn {i}"
  endif
enddef
def MapSwitchTab()
  for i in range(1, 9)
    execute $"nnoremap <Plug>(meta-{i}) <scriptcmd>SwitchTab({i})<CR>"
    execute $"nnoremap <silent> <leader>{i} <scriptcmd>SwitchTab({i})<CR>"
  endfor
enddef
MapSwitchTab()
# move [[[1
inoremap <silent> <Down> <C-R>=pumvisible() ? "\<lt>Down>" : "\<lt>C-O>gj"<CR>
inoremap <silent> <Up>   <C-R>=pumvisible() ? "\<lt>Up>" : "\<lt>C-O>gk"<CR>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <left>
inoremap <M-l> <Right>
# text object [[[1
xnoremap <silent> ag gg0oG$
onoremap <silent> ag :<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR>g``zz
xnoremap <silent> ae gg0oG$
onoremap <silent> ae :<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR>g``zz
# ]]]
# rsi [[[1
inoremap <C-A> <C-O>^
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
# CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
# so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
# spell correction for the first suggested
# inoremap <C-l> <C-g>u<ESC>[s1z=`]a<C-g>u

inoremap <expr> <C-E> col('.') > strlen(getline('.')) <bar><bar> pumvisible() ? "\<Lt>C-E>" : "\<Lt>End>"

noremap!        <Plug>(meta-b) <S-Left>
noremap!        <Plug>(meta-f) <S-Right>
noremap!        <Plug>(meta-d) <C-O>dw
cnoremap        <Plug>(meta-d) <S-Right><C-W>
# unimpared [[[1
# toogle line number and relative line number
def NumberOptions(): string
  return &number && &relativenumber ? 'nonumber norelativenumber' : 'number relativenumber'
enddef
nnoremap yon :set <C-R>=<SID>NumberOptions()<CR><CR>
# Buffer navigation
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
# quickfix list
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [Q :cNfile<CR>
nnoremap <silent> ]Q :cnfile<CR>
# location list (buffer local quickfix list)
nnoremap <silent> [s :lprevious<CR>
nnoremap <silent> ]s :lnext<CR>
nnoremap <silent> [S :lNfile<CR>
nnoremap <silent> ]S :lnfile<CR>
# file list -> load buffers using :args * :args **/*.js **/*.css
nnoremap <silent> [f :previous<CR>
nnoremap <silent> ]f :next<CR>
nnoremap <silent> [F :first<CR>
nnoremap <silent> ]F :last<CR>
# [c ]c for diff

# move lines
xnoremap <tab> :sil! m '>+1<CR>gv
xnoremap <s-tab> :sil! m '<-2<CR>gv


# ]]]
# mark ring [[[1
var mark_ring = [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}]
var mark_ring_i = 0

def g:MarkPush()
  mark_ring[mark_ring_i] = {'path': expand('%:p'), 'line': line('.'), 'col': col('.')}
  mark_ring_i = (mark_ring_i + 1) % len(mark_ring)
enddef

def g:MarkPop(d: number)
  mark_ring[mark_ring_i] = {'path': expand('%:p'), 'line': line('.'), 'col': col('.')}
  mark_ring_i = (mark_ring_i + d + len(mark_ring)) %  len(mark_ring)
  var mark = mark_ring[mark_ring_i]
  if !has_key(mark, 'path')
    echo 'empty mark_ping'
    return
  endif
  if mark.path !=# expand('%:p')
    silent exec 'e ' .. fnameescape(mark.path)
  endif
  call cursor(mark.line, mark.col)
enddef

nnoremap H <scriptcmd>g:MarkPop(-1)<CR>
nnoremap L <scriptcmd>g:MarkPop(1)<CR>
nnoremap <X1Mouse> <scriptcmd>g:MarkPop(-1)<CR>
nnoremap <X2Mouse> <scriptcmd>g:MarkPop(1)<CR>
# nnoremap mm <scriptcmd>g:MarkPush()<CR>

# nnoremap <c-m> <scriptcmd>feedkeys($"yyp{getpos('.')[2] - 1}l")<CR>
# external [[[1
nnoremap <silent> gX :call os#Gx()<CR>

import autoload 'term.vim'
xnoremap <expr> <space>t term.Send()
nnoremap <expr> <space>t term.Send()
nnoremap <expr> <space>tt term.Send() .. '_'
# ]]]
# vim:fdm=marker:fmr=[[[,]]]:ft=vim
