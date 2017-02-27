call plug#begin('~/.vim/bundle') " vim-plug 初始化

" Plugin List


" Enhancement
Plug 'KabbAmine/vCoolor.vim'
" Depends on Ripgrep
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neosnippet-snippets' 
Plug 'Shougo/neosnippet.vim' 
Plug 'Shougo/neoyank.vim'
Plug 'Yggdroot/indentLine'
Plug 'cohama/lexima.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'honza/vim-snippets'
Plug 'junegunn/goyo.vim', { 'for': [ 'markdown', 'rst', 'txt'] }
Plug 'junegunn/limelight.vim' 
Plug 'justinmk/vim-sneak'
Plug 'kien/rainbow_parentheses.vim'
" Depends on ctags
" https://github.com/universal-ctags/ctags
Plug 'majutsushi/tagbar'
Plug 'maralla/completor-neosnippet'
Plug 'maralla/completor.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreetoggle'}
Plug 'skywind3000/asyncrun.vim'
Plug 'takac/vim-hardtime'
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-smooth-scroll'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vimers/vim-youdao'

" Language
Plug 'PProvost/vim-ps1'
Plug 'Rykka/riv.vim', { 'for': 'rst' }
Plug 'Valloric/MatchTagAlways', { 'for': 'html' }
Plug 'amix/vim-zenroom2', { 'for': [ 'markdown', 'rst', 'txt'] }
Plug 'ap/vim-css-color'
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'ekalinin/Dockerfile.vim'
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'hdima/python-syntax', { 'for': 'python'} 
Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'javascript'] }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'rhysd/vim-clang-format'
Plug 'tikhomirov/vim-glsl' 

" Apperance
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'

call plug#end()

"" UI
colorscheme gruvbox
set bg=dark

if !exists("g:vimrc_loaded") 
  if has("gui_running")
    "au GUIEnter * simalt ~x " 窗口啓動時自動最大化
    "au GUIEnter * set lines=768 columns=1366 " 窗口啓動時自動最大化 
    set cmdheight=1
    set guioptions-=T "隱藏工具欄
    set guioptions-=L
    set guioptions-=r
    set guioptions-=m
    set guifont=Inziu\ Iosevka\ CL
    set langmenu=en_US
  endif " has
endif " exists(...)

set so=10
set number
set rnu " 相對行號
syntax on
filetype on
filetype plugin on
filetype indent on

call system('mkdir /tmp/.vim-undodir/')
let &undodir = '/tmp/.vim-undodir'
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

" go back to where you exited
autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal g'\"" |
      \ endif

set completeopt=longest,menu " preview

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

"按縮進或手動摺疊
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
set foldcolumn=0 "設置摺疊區域的寬度
set foldlevelstart=200
set foldlevel=200  " disable auto folding
" 用空格鍵來開關摺疊
nnoremap <space><space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
vnoremap <space><space> zf

let mapleader = "\<Space>"

"au BufNewFile *.py call ScriptHeader()
au BufNewFile *.sh call ScriptHeader()
au FileType vue syntax sync minlines=500

function! ScriptHeader()
  if &filetype == 'python'
    let header = "#!/usr/bin/env python2"
    let coding = "# -*- coding:utf-8 -*-"
    let future = "from __future__ import print_function, division, unicode_literals"
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
    call append(2, future)
    call append(4, cfg)
  endif
  normal ''
endfunction

source ~/.vim/config/lightline.vim
source ~/.vim/config/denite.vim
source ~/.vim/config/fcitx.vim
source ~/.vim/config/nerdtree.vim

source ~/.vim/config/go.vim
source ~/.vim/config/cpp.vim
source ~/.vim/config/python.vim

source ~/.vim/config/misc.vim
source ~/.vim/config/keymapping.vim

if filereadable(expand("~/.vim/config/local.vim"))
  source ~/.vim/config/local.vim
endif

