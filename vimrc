vim9script
set nocompatible
filetype plugin indent on
syntax on

g:mapleader   = "\<Space>"
g:localleader = "\\"

$VIMSTATE = $HOME .. '/.local/state/vim/'

if exists('#vimrc')
  augroup vimrc
    autocmd!
  augroup END
  augroup! vimrc
endif

# set confirm
set hidden
set autoindent shiftwidth=4 softtabstop=-1 expandtab # smarttab
set cinoptions=(0,t0,l1,:0,L0,g0,N-s cinkeys-=0#
set ttyfast
set ttimeout ttimeoutlen=25
set belloff=all shortmess=aoOTIc
set ruler display=lastline smoothscroll
set hlsearch incsearch ignorecase smartcase
set suffixes+=.a,.1,.class,.mkv,.mp4
set isfname-==
set path=.,,
set cpoptions=aABcfFqsZ # -e
# set breakindentopt=min:40
set wrap breakindent breakindentopt=sbr,list:-1 linebreak nojoinspaces
set formatoptions=tcqlnjromB1/
set fillchars=fold:\ ,vert:│
set virtualedit=block
set backspace=indent,eol,start
set nostartofline
set sidescroll=1 sidescrolloff=3 scrolloff=4
set nrformats=bin,hex,unsigned
set spelllang=en_us,cjk spellcapcheck= spellfile=$MYVIMDIR/spell/en.utf-8.add
# set spelloptions=camel
inoremap <C-b> <c-g>u<Esc>[s1z=`]a<c-g>u
set nospell
set diffopt=vertical,internal,filler,closeoff,indent-heuristic,hiddenoff,algorithm:histogram,inline:char,linematch:50
set number relativenumber cursorline cursorlineopt=number signcolumn=number
set conceallevel=0 concealcursor=n

set sessionoptions=buffers,curdir,help,tabpages,winsize,slash,unix,resize
set viewoptions=cursor,folds,slash,unix

# &errorformat ..= ',%f\|%\s%#%l col%\s%#%c%\s%#\| %m'
if executable('rg')
  set grepprg=rg\ -H\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

set laststatus=2 showcmd showmatch noshowmode
set modeline modelines=1
set matchpairs=(:),{:},[:],《:》,〈:〉,［:］,（:）,「:」,『:』,‘:’,“:”
set matchtime=0

set fileformat=unix fileformats=unix,dos
set fileencodings=ucs-bom,utf-8,utf-16le,gbk,big5,gb18030,gb2312,cp936,usc-bom,euc-jp
set encoding=utf-8
scriptencoding utf-8

set list listchars=tab:▸\ ,nbsp:␣,trail:⣿,extends:…,precedes:… showbreak=↪
augroup vimrc
  autocmd InsertEnter * set listchars-=trail:⣿
  autocmd InsertLeave * set listchars+=trail:⣿
augroup END

set foldopen+=jump foldlevelstart=999

if has("patch-9.0.1921")
  set jumpoptions=stack
endif

# Automatically save before commands like :next and :make
set autoread autowrite
set report=0 # Always report changed lines.
# set synmaxcol=99999 # Only highlight the first 500 columns.
set splitbelow splitright
set titlestring=VIM
set switchbuf=uselast
set tabpagemax=50
set nolangremap

if $W64DEVKIT != ""
  # set sh=sh shcf=-c sxq=\" sxe=
    $CFLAGS = "-g -gcodeview -Wall -Wextra -Wdouble-promotion -Wconversion
                \ -Wno-sign-conversion -Wno-unused-parameter
                \ -Wno-unused-function -Wno-unknown-pragmas
                \ -fsanitize=undefined
                \ -fsanitize-trap"
    # $LDFLAGS = "-nostartfiles"
else
    $CFLAGS = "-g3 -Wall -Wextra -Wdouble-promotion -Wconversion
                \ -Wno-sign-conversion -Wno-unused-parameter
                \ -Wno-unused-function -Wno-unknown-pragmas
                \ -fsanitize=undefined,address
                \ -fsanitize-undefined-trap-on-error"
  $LDFLAGS = " "
endif
$CXXFLAGS = $CFLAGS .. ' -std=c++23'

set makeprg=make\ -e
set efm^=%-G%f%l:\ note:%m


if filereadable($HOME .. '/local.vim')
  source $HOME/local.vim
endif

source $MYVIMDIR/pack.vim

# vim:fdm=marker:fmr=[[[,]]]:ft=vim
