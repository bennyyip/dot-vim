" Goodbye Ex mode
nnoremap Q gq

" unix2dos
nmap d<CR> :%s/\r//ge<CR>

" Reload .vimrc
nnoremap <leader>vr <Esc>:so $MYVIMRC<CR>

" File
nnoremap <leader>fed <Esc>:e ~/.vim/init.vim<CR>
nnoremap <leader>fs :w<CR>
nnoremap <leader>fq :x<CR>
nnoremap <leader>fE :<C-u>w !sudo tee %<CR>
nnoremap <leader>w :w<CR>

" Copy path
nnoremap <leader>fn :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
nnoremap <leader>fp :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

" Quit
nnoremap <leader>Q :q!<CR>
nnoremap <leader>q :q<CR>

" Buffer
nnoremap <silent> <leader><tab> :<C-u>b#<CR>
nnoremap <C-left> :bn<CR>
nnoremap <C-right> :bp<CR>
nnoremap <leader>bb :<C-u>Denite buffer<CR>
" Quickfix
nnoremap <leader>oe :copen<CR>

" Youdao
nnoremap <leader>oy :<C-u>Dic<CR>

" Windows
nnoremap <leader>ex :!start explorer %:p:h<CR>
nnoremap <leader>ps :!start powershell<CR>

" Tweak
vmap j gj
vmap k gk
nmap j gj
nmap k gk

"" depends on terryma/vim-smooth-scroll
"noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
"noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
"noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
"noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

nmap T :tabnew<cr>

"nmap <silent><Esc> :nohlsearch<CR>

inoremap <silent> <C-BS> <C-w>
cnoremap <C-a> <home>
cnoremap <C-e> <end>

" 移动分割窗口
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" 正常模式下 alt+j,k,h,l 调整分割窗口大小
nnoremap <M-j> :resize +5<cr>
nnoremap <M-k> :resize -5<cr>
nnoremap <M-h> :vertical resize -5<cr>
nnoremap <M-l> :vertical resize +5<cr>

" 插入模式移动光标 alt + 方向键
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <left>
inoremap <M-l> <Right>

" 中文字數統計
nnoremap <leader>wc :%s/[\u4E00-\u9FCC]//gn<CR>
" 全部字符統計：g<C-g>

" copy and paste
cmap <C-V>    <C-R>+
imap <C-V>    <C-r>+
imap <C-v> <C-r>+
vmap <C-c> "+y
vnoremap <BS> d
vnoremap <C-C> "+y
set pastetoggle=<F11>

" resolve vcs conflict (depends on tpope/vim-unimpaired)
map <leader>dg1 ]nd]n[ndd[ndd
map <leader>dg2 d]ndd]ndd

" Plugins

"Valloric/MatchTagAlways
nnoremap <leader>% :MtaJumpToOtherTag<cr>


