vim9script
import autoload 'utils.vim'
import autoload 'text.vim'
import autoload 'buf.vim'
import autoload 'os.vim'
const is_gvim = has('gui_running')
# move [[[1
inoremap <silent> <Down> <C-R>=pumvisible() ? "\<lt>Down>" : "\<lt>C-O>gj"<CR>
inoremap <silent> <Up>   <C-R>=pumvisible() ? "\<lt>Up>" : "\<lt>C-O>gk"<CR>
# inoremap <C-j> <Down>
# inoremap <C-k> <Up>
# inoremap <C-h> <left>
# inoremap <C-l> <Right>
nnoremap <c-d> <c-d>zz
nnoremap <c-u> <c-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
# edit [[[1
# open q:
set cedit=<C-Y>
# swap <c-n> and <c-x><c-n>
inoremap <expr> <C-N> pumvisible() ?  "\<C-N>" : "\<C-X>\<C-N>"
inoremap <C-X><C-N> <C-N>
inoremap <silent><expr> <C-O> pumvisible() ? "\<C-N>" : "\<C-X>\<C-O>"

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-P>" : "\<C-H>"

inoremap <Plug>(meta-o) <C-O>o
inoremap <Plug>(meta-O) <C-O>O
# get output from python
imap <C-R>c <esc>:let @a=""<CR>:let @a = execute( "py3 print()")<left><left><left>
# time
inoremap <silent> <C-G><C-T> <C-R>=repeat(complete(col('.'),map(["%Y-%m-%d %H:%M:%S","%a, %d %b %Y %H:%M:%S %z","%Y %b %d","%d-%b-%y","%a %b %d %T %Z %Y"],'strftime(v:val)')+[localtime()]),0)<CR>
inoremap <silent> <C-G><C-Y> <ESC><cmd>call setreg('a', getline('.')->slice(0, getpos('.')[2]))<BAR>put a<CR>A
# rsi [[[1
inoremap      <C-A> <C-O>^
inoremap <C-X><C-A> <C-A>
cnoremap      <C-A> <Home>
cnoremap <C-X><C-A> <C-A>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
# C-U sets a new undo point before deleting.
inoremap <C-U> <C-G>u<C-U>
# spell correction for the first suggested
# inoremap <C-l> <C-g>u<ESC>[s1z=`]a<C-g>u

inoremap <expr> <C-E> col('.') > strlen(getline('.')) <bar><bar> pumvisible() ? "\<Lt>C-E>" : "\<Lt>End>"

noremap! <Plug>(meta-b) <S-Left>
noremap! <Plug>(meta-f) <S-Right>
inoremap <Plug>(meta-d) <C-O>dw
cnoremap <Plug>(meta-d) <S-Right><C-W>
noremap! <Plug>(meta-n) <Down>
noremap! <Plug>(meta-p) <Up>

# text object [[[1
xnoremap <silent> ae gg0oG$
onoremap <silent> ae :<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR>g``zz
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
# yank [[[1
# inoremap <silent><C-v> <C-O>:set paste<CR><C-R>+<C-O>:set nopaste<CR>
inoremap <silent><C-z> <ESC>u
if $SSH_CONNECTION == ""
    xnoremap <silent><C-c> "+y
    cnoremap <C-v>         <C-R>+
    inoremap <silent><C-v> <C-R><C-o>+
endif
nnoremap Y   y$
xnoremap x  "_d
# do not overwrite register
def VisualPaste()
  setreg('a', getreg('"'))
  defer setreg('"', getreg('a'))
  norm! p
enddef
xnoremap p <scriptcmd>VisualPaste()<CR>
# xnoremap p "_dP
xnoremap <leader>p p
# select what I just pasted
nnoremap <expr> gp '`[' .. strpart(getregtype(), 0, 1) .. '`]'
# copy entire file contents to system clipboard
nnoremap yY <scriptcmd>os.Yank(getline(1, '$')->join("\n"))<CR>
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
# quick edit macro  | ["register]<c-g>m
nnoremap <c-g>m  :<c-u><c-r><c-r>='let @' .. v:register .. ' = ' .. string(getreg(v:register))<cr><c-f><left>
nnoremap Q @q
xnoremap Q :normal! @q<CR>
# repeat last command for each line of a visual selection
xnoremap . :normal .<CR>
# search and substitute [[[1
# nohl
def Refresh(doedit: bool)
    if doedit
        utils.KeepChangeMarksExec('edit')
    endif
    if has('diff')
        diffupdate
    endif
    normal! <C-L>
enddef
nnoremap <silent> <backspace> <scriptcmd>nohlsearch<BAR>Refresh(v:count > 0)<CR>
nnoremap z. <scriptcmd>call utils.KeepChangeMarksExec('w')<cr>z.
# quick substitute
xnoremap qs "zy:%s`<C-r>=$'\V{escape(getreg("z"), '/\\')}'->split("\n")->join('\n')<CR>``g<left><left>
nnoremap qs :%s`<C-R><C-W>``g<left><left>
xnoremap qS "zy:%S`<C-r>=$'\V{escape(getreg("z"), '/\\')}'->split("\n")->join('\n')<CR>``g<left><left>
nnoremap qS :%S`<C-R><C-W>``g<left><left>
nnoremap & n:&&<CR>
xnoremap & n:&&<CR>
# mark position before search
nnoremap / ms/
nnoremap ? ms?
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
    var temp = getreg('s')
    defer setreg('s', temp)
    norm! gv"sy
    setreg('/', '\V' .. substitute(escape(@s, cmdtype .. '\'), '\n', '\\n', 'g'))
enddef

nnoremap <silent> <leader>= <scriptcmd>utils.RemoveSpaces()<CR>
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
        botright copen
    endif
enddef
def ToggleLoc()
    if getwininfo()->filter('v:val.loclist')->len() > 0
        lclose
    else
        botright lopen
    endif
enddef
nnoremap <leader>q <scriptcmd>ToggleQF()<CR>
nnoremap <leader>l <scriptcmd>ToggleLoc()<CR>
# file, buffer [[[1
nnoremap <leader>fs <scriptcmd>utils.KeepChangeMarksExec('update')<CR>
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
# unimpared [[[1
# toogle line number and relative line number
def NumberOptions(): string
    return &number && &relativenumber ? 'nonumber norelativenumber' : 'number relativenumber'
enddef
nnoremap yon :set <C-R>=<SID>NumberOptions()<CR><CR>
def SpellOptions(): string
  return &spell ? 'nospell' : 'spell'
enddef
nnoremap yos :setlocal <C-R>=<SID>SpellOptions()<CR><CR>
# Buffer navigation
nnoremap <silent> [b :<C-U><C-R>=v:count1<CR>bprevious<CR>
nnoremap <silent> ]b :<C-U><C-R>=v:count1<CR>bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
# quickfix list
nmap <F6> :cnext<CR>
nmap <S-F6> :cprevious<CR>
nnoremap <silent> [q :<C-U><C-R>=v:count1<CR>cprevious<CR>
nnoremap <silent> ]q :<C-U><C-R>=v:count1<CR>cnext<CR>
nnoremap <silent> [Q :cNfile<CR>
nnoremap <silent> ]Q :cnfile<CR>
# quickfix and loclist
nnoremap <silent>  <q :call quickfixed#older()<CR>
nnoremap <silent>  >q :call quickfixed#newer()<CR>
# location list (buffer local quickfix list)
nnoremap <silent> [d :<C-U><C-R>=v:count1<CR>lprevious<CR>
nnoremap <silent> ]d :<C-U><C-R>=v:count1<CR>lnext<CR>
nnoremap <silent> [D :lNfile<CR>
nnoremap <silent> ]D :lnfile<CR>
# file list -> load buffers using :args * :args **/*.js **/*.css
nnoremap <silent> [f :<C-U><C-R>=v:count1<CR>previous<CR>
nnoremap <silent> ]f :<C-U><C-R>=v:count1<CR>next<CR>
nnoremap <silent> [F :first<CR>
nnoremap <silent> ]F :last<CR>
# [c ]c for diff

# move lines
xnoremap <tab> :sil! m '>+1<CR>gv
xnoremap <s-tab> :sil! m '<-2<CR>gv
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
# terminal [[[1
# set termwinkey=<C-\\>
import autoload 'term.vim'
xnoremap <expr> <space>t term.Send()
nnoremap <expr> <space>t term.Send()
nnoremap <expr> <space>tt term.Send() .. '_'
tnoremap <F1> <C-W>N
tnoremap <C-W><C-W> <C-W>.
# misc [[[1
# fold
nmap z] zo]z
nmap z[ zo[z
nnoremap <leader><space> za
# syntax
nnoremap <leader>Si  <scriptcmd>echo utils.Syninfo()<cr>
# diff
nnoremap <silent><leader>di :windo diffthis<CR>
nnoremap <silent><leader>du :windo diffupdate<CR>
nnoremap <silent><leader>do :windo diffoff<cr>
# resolve conflict. left and right
nnoremap <silent>gh <cmd>diffget //2<CR>
nnoremap <silent>gH <cmd>diffget //3<CR>
# linewise partial staging in visual-mode.
xnoremap <c-p> :diffput<cr>
xnoremap <c-o> :diffget<cr>
# tags
nnoremap '] <c-w>v<c-w>]
# vimrc
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
# external [[[1
nnoremap <silent> gX  :call os#Gx()<CR>
nnoremap <silent> gof :call os#FileManager()<CR>
nnoremap <silent> got :call os#Terminal()<CR>

# ]]]
# vim:fdm=marker:fmr=[[[,]]]:ft=vim
