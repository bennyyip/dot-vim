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
# settings [[[1
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
set isfname-== isfname+=@-@
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
set diffopt=vertical,internal,filler,closeoff,indent-heuristic,hiddenoff,algorithm:histogram,linematch:50
if has("patch-9.1.1753")
  set diffopt+=inline:char
endif
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

set makeprg=make\ -e
set efm^=%-G%f%l:\ note:%m


$RIPGREP_CONFIG_PATH = $HOME .. '/.ripgreprc'
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
# ]]]
# opts [[[1
g:loaded_2html_plugin     = 1
g:loaded_getscriptPlugin  = 1
g:loaded_gzip             = 1
g:loaded_logiPat          = 1
# g:loaded_manpager_plugin  = 1
# g:loaded_matchparen       = 1
g:loaded_rrhelper         = 1
g:loaded_spellfile_plugin = 1
g:loaded_tarPlugin        = 1
g:loaded_vimballPlugin    = 1
g:loaded_zipPlugin        = 1
g:loaded_netrw            = 1
g:loaded_netrwPlugin      = 1
g:loaded_tutor_mode_plugin = 1

g:nogx = true
g:vimsyn_folding = 'f'

g:load_black = 1
g:loaded_fzf = 1

g:c_no_comment_fold = 1
g:c_comment_strings = 1
g:c_no_curly_error = 1

# this makes sure that shell scripts are highlighted
# as bash scripts and not sh scripts
g:is_posix = 1

g:python_highlight_all = 1
# g:markdown_folding = 1

g:snips_author = 'Ben Yip'
g:obsidian_vault = $HOME .. '/Obsidian-Vault'

# ]]]
if filereadable($HOME .. '/local.vim')
  source $HOME/local.vim
endif

source $MYVIMDIR/pack.vim
# vim:fdm=marker:fmr=[[[,]]]:ft=vim:fdl=0
