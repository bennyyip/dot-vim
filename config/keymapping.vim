" File 
nnoremap <leader>feR <Esc>:so ~/.vim/init.vim<CR>
nnoremap <leader>fed <Esc>:e ~/.vim/init.vim<CR>
nnoremap <leader>fs :w<CR>
nnoremap <leader>fq :x<CR>
nnoremap <leader>fn :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
nnoremap <leader>fp :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR> 

" Quit
nnoremap <leader>qQ :x<CR>
nnoremap <leader>qq :q<CR>

" Buffer
nnoremap <silent> <leader><tab> :<C-u>b#<CR>
nnoremap <C-left> :bn<CR>
nnoremap <C-right> :bp<CR>
nnoremap <leader>bb :<C-u>Denite buffer<CR>

nnoremap <leader>oy :<C-u>Dic<CR>

" Windows
nnoremap <leader>ex :!start explorer %:p:h<CR>
nnoremap <leader>ps :!start powershell<CR>

" Tweak
vmap j gj
vmap k gk
nmap j gj
nmap k gk

nmap T :tabnew<cr>

nmap <silent><Esc> :nohlsearch<CR>

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

" Plugins

"Valloric/MatchTagAlways
nnoremap <leader>% :MtaJumpToOtherTag<cr>

"Goyo
nnoremap <silent> <leader>z :Goyo<cr>
