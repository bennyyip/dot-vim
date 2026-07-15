vim9script

import autoload '../autoload/unimpaired.vim'

nnoremap <silent> <expr> [<space> unimpaired.BlankUp()
nnoremap <silent> <expr> ]<space> unimpaired.BlankDown()

nnoremap <silent> <expr> [e unimpaired.MoveUp()
nnoremap <silent> <expr> ]e unimpaired.MoveDown()
xnoremap <silent> <expr> [e unimpaired.MoveSelectionUp()
xnoremap <silent> <expr> ]e unimpaired.MoveSelectionDown()
xnoremap <C-Down> :sil! m '>+1<CR>gv
xnoremap <C-Up> :sil! m '<-2<CR>gv

# toogle line number and relative line number
nnoremap yon <scriptcmd>unimpaired.ToggleNumberOptions()<CR>
nnoremap yos <scriptcmd>unimpaired.ToggleSpellOptions()<CR>
# Buffer navigation
nnoremap <silent> [a :<C-U><C-R>=v:count1<CR>previous<CR>
nnoremap <silent> ]a :<C-U><C-R>=v:count1<CR>next<CR>
nnoremap <silent> [A :first<CR>
nnoremap <silent> ]A :last<CR>
nnoremap <silent> [b :<C-U><C-R>=v:count1<CR>bprevious<CR>
nnoremap <silent> ]b :<C-U><C-R>=v:count1<CR>bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
# quickfix list
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
# nnoremap <silent> [f :<C-U><C-R>=v:count1<CR>previous<CR>
# nnoremap <silent> ]f :<C-U><C-R>=v:count1<CR>next<CR>
# nnoremap <silent> [F :first<CR>
# nnoremap <silent> ]F :last<CR>
nnoremap <silent> [f <scriptcmd>unimpaired.EditFileByOffset(-v:count1)<CR>
nnoremap <silent> ]f <scriptcmd>unimpaired.EditFileByOffset(v:count1)<CR>
nnoremap <silent> [F <scriptcmd>unimpaired.EditFileByOffset(0, -1)<CR>
nnoremap <silent> ]F <scriptcmd>unimpaired.EditFileByOffset(0, 1)<CR>

# From: https://github.com/dstein64/dotfiles/blob/master/packages/vim/.vimrc
noremap <silent> [< <scriptcmd>unimpaired.MoveRelativeToIndent(-1, -1, !v:count)<cr>
noremap <silent> ]< <scriptcmd>unimpaired.MoveRelativeToIndent(1, -1, !v:count)<cr>
noremap <silent> [= <scriptcmd>unimpaired.MoveRelativeToIndent(-1, 0, !v:count)<cr>
noremap <silent> ]= <scriptcmd>unimpaired.MoveRelativeToIndent(1, 0, !v:count)<cr>
noremap <silent> [> <scriptcmd>unimpaired.MoveRelativeToIndent(-1, 1, !v:count)<cr>
noremap <silent> ]> <scriptcmd>unimpaired.MoveRelativeToIndent(1, 1, !v:count)<cr>
noremap <silent> [n <scriptcmd>unimpaired.GotoConflictOrDiff(true)<cr>
noremap <silent> ]n <scriptcmd>unimpaired.GotoConflictOrDiff(false)<cr>
noremap <silent> [, <scriptcmd>unimpaired.GotoComment(true)<cr>
noremap <silent> ], <scriptcmd>unimpaired.GotoComment(false)<cr>
noremap <silent> [t <scriptcmd>unimpaired.GotoLongLine(true)<cr>
noremap <silent> ]t <scriptcmd>unimpaired.GotoLongLine(false)<cr>
