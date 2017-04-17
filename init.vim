" Plugin List [[[1
call plug#begin('~/.vim/bundle') " vim-plug 初始化
" Enhancement [[[2
Plug 'KabbAmine/vCoolor.vim'
" Depends on Ripgrep
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neoyank.vim'
Plug 'w0rp/ale'
Plug 'Yggdroot/indentLine'
Plug 'cohama/lexima.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'honza/vim-snippets'
Plug 'junegunn/goyo.vim', { 'for': [ 'markdown', 'rst', 'txt'] }
Plug 'junegunn/limelight.vim'
Plug 'justinmk/vim-sneak'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kien/rainbow_parentheses.vim'
" Depends on ctags
" https://github.com/universal-ctags/ctags
Plug 'bennyyip/tagbar'
Plug 'maralla/completor-neosnippet'
Plug 'maralla/completor.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'skywind3000/asyncrun.vim'
"Plug 'takac/vim-hardtime'
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-smooth-scroll'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vimers/vim-youdao'
"]]]
" Language [[[2
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'PProvost/vim-ps1'
Plug 'Rykka/riv.vim', { 'for': 'rst' }
Plug 'Valloric/MatchTagAlways', { 'for': 'html' }
Plug 'amix/vim-zenroom2', { 'for': [ 'markdown', 'rst', 'txt'] }
Plug 'lilydjwg/colorizer'
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'ekalinin/Dockerfile.vim'
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'hdima/python-syntax', { 'for': 'python'}
Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'javascript'] }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'rhysd/vim-clang-format'
Plug 'tikhomirov/vim-glsl'
Plug 'othree/html5.vim', {'for': 'html'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'Shiracamus/vim-syntax-x86-objdump-d'
Plug 'racer-rust/vim-racer', {'for': 'rust'}
"]]]
" Apperance [[[2
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'mhinz/vim-startify'
"]]]
call plug#end()
"]]]
" set [[[1
" general settings [[[2
syntax on
filetype on
filetype plugin on
filetype indent on

call system('mkdir /tmp/.vim-undodir/')
let &undodir = '/tmp/.vim-undodir'

set so=10
set number
set rnu " 相對行號

set undofile

set autochdir
set path+=**

set nrformats-=octal

" turn off bell
set visualbell

set wildmenu
set autoread
set formatoptions+=j " Delete comment char when joining lines

"set list lcs=tab:\|\

if has('mouse')
  set mouse=a
  set selectmode=mouse,key
  set nomousehide
endif

set autoindent
set modeline
set cursorline
"set cursorcolumn

set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

set showmatch
set matchtime=0
set nobackup
set nowritebackup
set directory=~/.vim/.swapfiles

" 設置 alt 鍵不映射到菜單欄
set winaltkeys=no

"在insert模式下能用刪除鍵進行刪除
set backspace=indent,eol,start

set fenc=utf-8
set fencs=utf-8,gbk,gb18030,gb2312,cp936,usc-bom,euc-jp
set enc=utf-8
set completeopt=longest,menu " preview
set hidden

"按縮進或手動摺疊
"augroup vimrc
"  au BufReadPre * setlocal foldmethod=indent
"  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
"augroup END
"set foldcolumn=0 "設置摺疊區域的寬度
"set foldlevelstart=200
"set foldlevel=200  " disable auto folding
" ]]]
" apperance [[[2
colorscheme gruvbox
set bg=dark

if !exists("g:vimrc_loaded")
  if has("gui_running")
    "au GUIEnter * set lines=768 columns=1366 " 窗口啓動時自動最大化
    set cmdheight=1
    set guioptions-=T "隱藏工具欄
    set guioptions-=L
    set guioptions-=r
    set guioptions-=m
    set langmenu=en_US
    if has('win32') || has('win64')
      au GUIEnter * simalt ~x " 窗口啓動時自動最大化
      set guifont=Inziu\ Iosevka\ CL:h14
    else
      set guifont=Monospace\ 14
    endif

  endif " has
endif " exists(...)
"]]]
"]]]
"map[[[1
" leader [[[2
let mapleader = "\<Space>"
" 用空格鍵來開關摺疊 [[[2
nnoremap <space><space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
vnoremap <space><space> zf
"   g[jk] [[[2
nmap <M-j> gj
nmap <M-k> gk
vmap <M-j> gj
" Goodbye Ex mode [[[2
nnoremap Q gq
" unix2dos [[[2
nmap d<CR> :%s/\r//ge<CR>
" Reload .vimrc [[[2
nnoremap <leader>vr <Esc>:so $MYVIMRC<CR>
" File [[[2
nnoremap <leader>fed <Esc>:e ~/.vim/init.vim<CR>
nnoremap <leader>fs :w<CR>
nnoremap <leader>fq :x<CR>
nnoremap <leader>fE :<C-u>w !sudo tee %<CR>
nnoremap <leader>w :w<CR>
" Copy path [[[2
nnoremap <leader>fn :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
nnoremap <leader>fp :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>
" Quit [[[2
nnoremap <leader>Q :q!<CR>
nnoremap <leader>q :q<CR>
" Buffer [[[2
nnoremap <silent> <leader><tab> :<C-u>b#<CR>
nnoremap <C-left> :bn<CR>
nnoremap <C-right> :bp<CR>
nnoremap <leader>bb :<C-u>Denite buffer<CR>
" Quickfix [[[2
nnoremap <leader>oe :copen<CR>
" Youdao [[[2
nnoremap <leader>oy :<C-u>Dic<CR>
" Windows [[[2
nnoremap <leader>ex :!start explorer %:p:h<CR>
nnoremap <leader>ps :!start powershell<CR>

" Tweak [[[2

nmap T :tabnew<cr>

nmap ' <C-W>
nmap Y y$
nmap :; :AsyncRun<space>
nmap :: :!<space>

inoremap <silent> <C-BS> <C-w>
cnoremap <C-a> <home>
cnoremap <C-e> <end>
"     上下移动一行文字[[[2
nmap <C-j> mz:m+<cr>`z
nmap <C-k> mz:m-2<cr>`z
vmap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z
" 正常模式下 alt+j,k,h,l 调整分割窗口大小 [[[2
nnoremap <M-j> :resize +5<cr>
nnoremap <M-k> :resize -5<cr>
nnoremap <M-h> :vertical resize -5<cr>
nnoremap <M-l> :vertical resize +5<cr>
" 插入模式移动光标 alt + 方向键 [[[2
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <left>
inoremap <M-l> <Right>
" 中文字數統計 [[[2
nnoremap <leader>wc :%s/[\u4E00-\u9FCC]//gn<CR>
" 全部字符統計：g<C-g>

" copy and paste [[[2
cmap <C-V>    <C-R>+
imap <C-V>    <C-r>+
imap <C-v> <C-r>+
vmap <C-c> "+y
vnoremap <BS> d
vnoremap <C-C> "+y
" resolve vcs conflict (depends on tpope/vim-unimpaired) [[[2
set pastetoggle=<F11>
map <leader>dg1 ]nd]n[ndd[ndd
map <leader>dg2 d]ndd]ndd
" Plugins

"Valloric/MatchTagAlways
nnoremap <leader>% :MtaJumpToOtherTag<cr>


"]]]
"autocmd [[[1
" go back to where you exited
autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal g'\"" |
      \ endif



au BufNewFile *.py call s:ScriptHeader()
au BufNewFile *.sh call s:ScriptHeader()
au FileType vue syntax sync minlines=500

function! s:ScriptHeader()
  if &filetype == 'python'
    let header = "#!/usr/bin/env python3"
    let coding = "# -*- coding:utf-8 -*-"
    let cfg = "# vim: ts=4 sw=4 sts=4 expandtab"
  elseif &filetype == 'sh'
    let header = "#!/bin/bash"
  endif
  let line = getline(1)
  if line == header
    return
  endif
  normal m'
  call append(0,header)
  if &filetype == 'python'
    call append(1, coding)
    call append(3, cfg)
  endif
  normal ''
endfunction
" noplaintext [[[2
" Prevent various Vim features from keeping the contents of pass(1) password
" files (or any other purely temporary files) in plaintext on the system.
"
" Either append this to the end of your .vimrc, or install it as a plugin with
" a plugin manager like Tim Pope's Pathogen.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
"

" Don't backup files in temp directories or shm
if exists('&backupskip')
    set backupskip+=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
endif

" Don't keep swap files in temp directories or shm
if has('autocmd')
    augroup swapskip
        autocmd!
        silent! autocmd BufNewFile,BufReadPre
            \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
            \ setlocal noswapfile
    augroup END
endif

" Don't keep undo files in temp directories or shm
if has('persistent_undo') && has('autocmd')
    augroup undoskip
        autocmd!
        silent! autocmd BufWritePre
            \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
            \ setlocal noundofile
    augroup END
endif

" Don't keep viminfo for files in temp directories or shm
if has('viminfo')
    if has('autocmd')
        augroup viminfoskip
            autocmd!
            silent! autocmd BufNewFile,BufReadPre
                \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
                \ setlocal viminfo=
        augroup END
    endif
endif
"]]]
"plugin config [[[1
"lightline [[[2
set laststatus=2

"g:lightline[[[3
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename'] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'asyncrun', 'fileformat', 'fileencoding', 'filetype'] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightlineModified',
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \ },
      \ 'component' : {
      \   'asyncrun': '%{g:asyncrun_status}'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

function! LightlineModified() "[[[3
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! LightlineReadonly() "[[[3
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? "\ue0a2" : ''
endfunction
function! LightlineFilename() "[[[3
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'denite' ? denite#get_status_sources() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction
function! LightlineFugitive() "[[[3
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? "\ue0a0 ".branch : ''
    endif
  catch
  endtry
  return ''
endfunction
function! LightlineFileformat() "[[[3
  return winwidth(0) > 70 ? &fileformat : ''
endfunction
function! LightlineFiletype() "[[[3
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction
function! LightlineFileencoding() "[[[3
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction
function! LightlineMode() "[[[3
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'denite' ? 'Denite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ lightline#mode()[0]
        "\ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
"tagbar [[[3
let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction
"denite [[[3
let g:denite_force_overwrite_statusline = 0
"denite [[[2
" Ripgrep for file_rec "[[[3
call denite#custom#var('file_rec', 'command',
	\ ['rg', '--files', ''])
" Ripgrep command on grep source "[[[3
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
    \ ['--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
" Change default prompt "[[[3
call denite#custom#option('default', 'prompt', '>')
" Change ignore_globs "[[[3
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])
" Sort behavior "[[[3
call denite#custom#source(
      \ 'file_rec', 'sorters', ['sorter_sublime'])
" Key mapping(u for unite, predecessor of denite)"[[[3
nnoremap <silent> <leader>ff :<C-u>Denite file_rec -no-statusline<CR>
nnoremap <silent> <leader>fr :<C-u>Denite file_mru<CR>
nnoremap <silent> <leader>u+ :<C-u>Denite -resume -immediately  -select=+1<CR>
nnoremap <silent> <leader>u- :<C-u>Denite -resume -immediately  -select=-1<CR>
nnoremap <silent> <leader>ub :<C-u>Denite buffer<CR>
nnoremap <silent> <leader>ug :<C-u>Denite grep<CR>
nnoremap <silent> <leader>uj :<C-u>Denite line<CR>
nnoremap <silent> <leader>ur :<C-u>Denite -resume<CR>
nnoremap <silent> <leader>ut :<C-u>Denite filetype<CR>
nnoremap <silent> <leader>uw :<C-u>DeniteCursorWord grep<CR><CR>
nnoremap <silent> <leader>uy :<C-u>Denite neoyank<CR>
"fcitx [[[2
let g:input_toggle = 0
function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction

function! Fcitx2zh()
   let s:input_status = system("fcitx-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
   endif
endfunction

set ttimeoutlen=150
"退出插入模式
autocmd InsertLeave * call Fcitx2en()
"进入插入模式
autocmd InsertEnter * call Fcitx2zh()
"nerdtree [[[2
map nt :NERDTreeToggle<cr>
nmap nT :NERDTreeFind<cr>
" nmap nT :NERDTreeTabsToggle<cr>
let NERDTreeShowBookmarks=0
let NERDTreeMouseMode=2

" let g:nerdtree_tabs_focus_on_files=1
" let g:nerdtree_tabs_open_on_gui_startup=0

let NERDTreeWinSize=25
let NERDTreeIgnore = ['\.pyc$','\.exe$']
let NERDTreeMinimalUI=0
let NERDTreeDirArrows=1

"let g:newrw_ftp_cmd = 'lftp'
let g:netrw_altv          = 1
let g:netrw_fastbrowse    = 2
let g:netrw_keepdir       = 1
let g:netrw_liststyle     = 3
let g:netrw_retmap        = 1
let g:netrw_silent        = 1
let g:netrw_special_syntax= 1
let g:netrw_browse_split = 3
let g:netrw_banner = 0

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"> How can I open NERDTree automatically when vim starts up on opening a directory?

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"extra [[[1 TODO merge extra config
source ~/.vim/config/misc.vim
" vim:fdm=marker:fmr=[[[,]]]

