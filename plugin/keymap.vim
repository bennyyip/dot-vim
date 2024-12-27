vim9script
const is_gvim = has('gui_running')
# misc [[[1
nnoremap <localleader>j :set ft=javascript<CR>
nnoremap <localleader>h :set ft=html<CR>
# fold [[[3
nmap z] zo]z
nmap z[ zo[z
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
nnoremap <leader>Ss  :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<cr>
# diff [[[3
nnoremap <silent><leader>di :windo diffthis<CR>
nnoremap <silent><leader>du :windo diffupdate<CR>
nnoremap <silent><leader>do :windo diffoff<CR>
# linewise partial staging in visual-mode.
xnoremap <c-p> :diffput<cr>
xnoremap <c-o> :diffget<cr>
# toggle iwhite
nnoremap yo<space> :set <C-R>=(&diffopt =~# 'iwhite') ? 'diffopt-=iwhite' : 'diffopt+=iwhite'<CR><CR>
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
      \ .. '<CR><C-L>'
nnoremap z. :call ben#save_change_marks()<Bar>w<Bar>call ben#restore_change_marks()<cr>z.
# window [[[1
# quick <C-w>
nnoremap ' <C-w>
nnoremap '' <C-w>w
# edit [[[1
inoremap "<space><space> ""<ESC>i
inoremap '<space><space> ''<ESC>i
inoremap (<space><space> ()<ESC>i
inoremap [<space><space> []<ESC>i
inoremap <<space><space> <><ESC>i
inoremap {<space><space> {<space><space>}<ESC>hi
inoremap (<CR> (<CR>)<Esc>O
inoremap {<CR> {<CR>}<Esc>O
inoremap [<CR> [<CR>]<Esc>O
inoremap (; (<space><space>);<Esc>hhi
inoremap (, (<space><space>),<Esc>hhi
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
# yank and paste [[[1
cnoremap <C-v>         <C-R>+
inoremap <silent><C-v> <C-O>:set paste<CR><C-R>+<C-O>:set nopaste<CR>
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
# yank filepath
nnoremap <silent> <leader>yp :let @+ = expand("%:p")<cr>:let @" = expand("%:p")<cr>
# vimrc [[[1
nnoremap <silent><leader>fed :e $VIMRC<CR>
nnoremap <silent><leader>fee :source $VIMRC<CR>
# run current line
nnoremap <silent> yr :exec getline('.') \| echo 'executed!'<CR>
# visual [[[1
# keep selection when indent line in visual mode
xnoremap <expr> > v:count ? ">" : ">gv"
xnoremap <expr> < v:count ? "<" : "<gv"
# niceblock
xnoremap <expr> I (mode() =~# '[vV]' ? '<C-v>^o^I' : 'I')
xnoremap <expr> A (mode() =~# '[vV]' ? '<C-v>0o$A' : 'A')
# macro [[[1
# quick edit macro  | ["register]<leader>m
nnoremap <leader>em  :<c-u><c-r><c-r>='let @' .. v:register .. ' = ' .. string(getreg(v:register))<cr><c-f><left>
nnoremap Q @q
xnoremap Q :normal @q<CR>
# repeat last command for each line of a visual selection
xnoremap . :normal .<CR>
# search and substitute [[[1
# quick substitute
vnoremap qs "zy:%s`<C-R>z``g<left><left>
nnoremap qs :%s`<C-R><C-W>``g<left><left>
vnoremap qS "zy:%S`<C-R>z``g<left><left>
nnoremap qS :%S`<C-R><C-W>``g<left><left>
nnoremap & n:&&<CR>
xnoremap & n:&&<CR>
# mark position before search
nnoremap / ms/
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

# file, buffer [[[1
nnoremap <leader>fs :w<CR>
nnoremap <leader>fy :let @+=expand("%")<CR>:echo "buffer filename copied"<CR>
nnoremap <leader>fP :let @+=expand("%:p")<CR>:echo "buffer path copied"<CR>
nnoremap cd :lcd %:p:h<bar>pwd<cr>
nnoremap cu :lcd ..<bar>pwd<cr>

nnoremap <silent><leader><tab> :<C-u>b!#<CR>


def DailyNote()
  const filename = expand($HOME .. "/Obsidian-Vault/0003 Journal/" .. strftime('%Y/W%W/%Y-%m-%d') .. '.md')
  const daily_note_dir = fnamemodify(filename, ':h')
  if !isdirectory(daily_note_dir)
    call mkdir(daily_note_dir, 'p')
  endif
  execute 'edit' fnameescape(filename)
enddef
nnoremap <leader>v :call <SID>DailyNote()<CR>
# tab [[[1
nmap     T :tabnew<cr>
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>
noremap  <silent><C-tab> :tabprev<CR>
inoremap <silent><C-tab> <ESC>:tabprev<CR>
nnoremap <silent><leader>tc :tabclose<CR>
nnoremap <silent><leader>to :tabonly<CR>
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
inoremap        <C-A> <C-O>^
cnoremap        <C-A> <Home>

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
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]Q :clast<CR>
# location list (buffer local quickfix list)
nnoremap <silent> [l :lprevious<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [L :lfirst<CR>
nnoremap <silent> ]L :llast<CR>
# file list -> load buffers using :args * :args **/*.js **/*.css
nnoremap <silent> [f :previous<CR>
nnoremap <silent> ]f :next<CR>
nnoremap <silent> [F :first<CR>
nnoremap <silent> ]F :last<CR>
# [c ]c for diff

def MapMeta(x: string)
  for m in ["n", "c"]
    const cmd = mapcheck($"<Plug>(meta-{x})", m)
    if cmd != ""
      # echom $"{m} {x} {cmd}"
      execute is_gvim ? $"{m}map <M-{x}> <Plug>(meta-{x})"
        : $"{m}map <ESC>{x} <Plug>(meta-{x})"
    endif
  endfor
  if mapcheck($"<Plug>(meta-{x})", "i") != ""
    # map <ESC> slows entering normal mode. so only map for gui
    if is_gvim
      execute $"nmap <M-{x}> <Plug>(meta-{x})"
    endif
  endif
enddef

for i in range(33, 122)
  MapMeta(nr2char(i))
endfor

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

# vim:fdm=marker:fmr=[[[,]]]:ft=vim
