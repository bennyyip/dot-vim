set nocompatible
filetype off

call plug#begin('~/.vim/bundle') " vim-plug 初始化

" Plugin List

Plug 'Chiel92/vim-autoformat'
Plug 'Valloric/YouCompleteMe', {'do': 'CXX=clang++ CC=clang python install.py --clang-completer'}
Plug 'bling/vim-airline'
Plug 'jrosiek/vim-mark'
Plug 'kien/ctrlp.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'majutsushi/tagbar'
Plug 'morhetz/gruvbox'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'

call plug#end()

set guifont=Inziu\ Iosevka\ SC:h14
colorscheme gruvbox

"" UI
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
"nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
"vnoremap <space> zf

au FileType cpp nnoremap <F5> <Esc>:w<CR>:!bash -c "clang++ -Wall -std=c++14 % -o /tmp/a.out && /tmp/a.out"<CR>
au FileType cpp inoremap <F5> <Esc>:w<CR>:!bash -c "clang++ -Wall -std=c++14 % -o /tmp/a.out && /tmp/a.out"<CR>
inoremap <silent> <F3> <Esc>:Autoformat<CR>:w<CR>i
nnoremap <silent> <F3> <Esc>:Autoformat<CR>:w<CR>


set smartcase
set ignorecase
set nohlsearch
set incsearch
set autochdir

vmap j gj
vmap k gk
nmap j gj
nmap k gk

nmap T :tabnew<cr>

nmap <silent><Esc> :nohl<CR>

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

source ~/.vim/config/airline.vim
source ~/.vim/config/nerdcommenter.vim
source ~/.vim/config/nerdtree.vim
source ~/.vim/config/rainbow_brackets.vim
source ~/.vim/config/syntastic.vim
source ~/.vim/config/tagbar.vim
source ~/.vim/config/ycm.vim

source ~/.vim/config/leader.vim

if filereadable(expand("~/.vim/config/local.vim"))
    source ~/.vim/config/local.vim
endif
