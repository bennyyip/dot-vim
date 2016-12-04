set nocompatible
filetype off

call plug#begin('~/.vim/bundle') " vim-plug 初始化

" Plugin List

" Enhancement 
"Plug 'jrosiek/vim-mark'
"Plug 'kien/ctrlp.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'KabbAmine/vCoolor.vim'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'PProvost/vim-ps1'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neomru.vim'
Plug 'SirVer/ultisnips'
Plug 'Valloric/YouCompleteMe', {'do': 'CXX=clang++ CC=clang python install.py --clang-completer'}
Plug 'Yggdroot/indentLine'
Plug 'bkad/CamelCaseMotion'
Plug 'easymotion/vim-easymotion'
Plug 'honza/vim-snippets'
Plug 'jlanzarotta/bufexplorer'
Plug 'kien/rainbow_parentheses.vim'
Plug 'majutsushi/tagbar'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'vimers/vim-youdao'

" Language
Plug 'ap/vim-css-color'
Plug 'hdima/python-syntax'
Plug 'mattn/emmet-vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tikhomirov/vim-glsl'
Plug 'tpope/vim-fugitive'
Plug 'vim-gitgutter'

" Apperance
Plug 'bling/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'

call plug#end()

set guifont=Inziu\ Iosevka\ SC:h14
colorscheme gruvbox

"" UI
colorscheme molokai
let g:molokai_original = 1
if !exists("g:vimrc_loaded")
  if has("gui_running")
    au GUIEnter * simalt ~x " 窗口启动时自动最大化
    set cmdheight=1
    set guioptions-=T "隐藏工具栏
    set guioptions-=L
    set guioptions-=r
    set guioptions-=m
    set guifont=Inziu\ Iosevka\ SC:h14
    colorscheme gruvbox
    set langmenu=en_US
    "set linespace=0
  endif " has
endif " exists(...)

set so=10
set number
syntax on
filetype on
filetype plugin on
filetype indent on

set list lcs=tab:\|\

if has("autocmd")  " go back to where you exited
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif
endif

set completeopt=longest,menu " preview

if has('mouse')
  set mouse=a
  set selectmode=mouse,key
  set nomousehide
endif

set autoindent
set modeline
set cursorline
set cursorcolumn

set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

set showmatch
set matchtime=0
set nobackup
set nowritebackup
set directory=~/.vim/.swapfiles


if has('nvim')
  set termguicolors
  set ttimeout
  set ttimeoutlen=0
endif

"在insert模式下能用删除键进行删除
set backspace=indent,eol,start

set fenc=utf-8
set fencs=utf-8,gbk,gb18030,gb2312,cp936,usc-bom,euc-jp
set enc=utf-8

"按缩进或手动折叠
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
set foldcolumn=0 "设置折叠区域的宽度
set foldlevelstart=200
set foldlevel=200  " disable auto folding
" 用空格键来开关折叠
nnoremap <space><space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
vnoremap <space><space> zf



set ignorecase
set smartcase
set hlsearch
set incsearch
set autochdir

vmap j gj
vmap k gk
nmap j gj
nmap k gk

nmap T :tabnew<cr>

nmap <silent><Esc> :nohlsearch<CR>

imap <silent> <C-BS> <Esc>dbi
imap <silent> <C-Del> <Esc>dwi

let mapleader = "\<Space>"

au FileType c,cpp,h,java,css,js,nginx,scala,go inoremap  <buffer>  {<CR> {<CR>}<Esc>O

"au BufNewFile *.py call ScriptHeader()
au BufNewFile *.sh call ScriptHeader()
au FileType vue syntax sync minlines=500

function ScriptHeader()
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

source ~/.vim/config/CamelCaseMotion.vim
source ~/.vim/config/airline.vim
source ~/.vim/config/denite.vim
source ~/.vim/config/easymotion.vim
source ~/.vim/config/gitgutter.vim
source ~/.vim/config/indentLine.vim
source ~/.vim/config/nerdcommenter.vim
source ~/.vim/config/nerdtree.vim
source ~/.vim/config/python.vim
source ~/.vim/config/rainbow_brackets.vim
source ~/.vim/config/syntastic.vim
source ~/.vim/config/tagbar.vim
source ~/.vim/config/ultisnips.vim
source ~/.vim/config/vim-bookmark.vim
source ~/.vim/config/vim-cpp-enhanced-highlight.vim
source ~/.vim/config/ycm.vim

source ~/.vim/config/leader.vim

if filereadable(expand("~/.vim/config/local.vim"))
  source ~/.vim/config/local.vim
endif
