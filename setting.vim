vim9script
# Setting [[[1
const is_tty = !match(&term, 'linux')
# general settings [[[2
set nocompatible
# init [[[3
g:mapleader = "\<Space>"
g:localleader = "\\"
g:vimsyn_folding = 'f'
g:is_bash = 1
g:lisp_rainbow = 1

g:markdown_fenced_languages = ['vim']

g:loaded_2html_plugin = 1
g:loaded_getscriptPlugin = 1
g:loaded_gzip = 1
g:loaded_logiPat = 1
g:loaded_logipat = 1
g:loaded_manpager_plugin = 1
# let g:loaded_matchparen = 1
g:loaded_rrhelper = 1
g:loaded_spellfile_plugin = 1
g:loaded_tarPlugin = 1
g:loaded_vimballPlugin = 1
g:loaded_zipPlugin = 1

# indent settings [[[3
set autoindent
set cinoptions=>2,l1,p0,)50,*50,t0
# Don't mess with 'tabstop', with 'expandtab' it isn't used.
# Instead set softtabstop=-1, then 'shiftwidth' is used.
set smarttab expandtab shiftwidth=4 softtabstop=-1
# display settings [[[3
# set display=lastline
set laststatus=2
set list
set modeline
set modelines=1
set nostartofline
set numberwidth=1
set shortmess=aoOTIc
set showcmd
set showmatch
set matchtime=0
set showmode

set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,utf-16le,gbk,big5,gb18030,gb2312,cp936,usc-bom,euc-jp
set encoding=utf-8
scriptencoding utf-8

if !is_tty
  if has('multi_byte') && &encoding ==# 'utf-8'
    &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
    &fillchars = 'diff: '  # ▚
    &showbreak = '↳ '
    highlight VertSplit ctermfg=242
    augroup vimrc
      autocmd InsertEnter * set listchars-=trail:⣿
      autocmd InsertLeave * set listchars+=trail:⣿
    augroup END
  else
    &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
    #let &fillchars = 'stlnc:#'
    &showbreak = '-> '
    augroup vimrc
      autocmd InsertEnter * set listchars-=trail:.
      autocmd InsertLeave * set listchars+=trail:.
    augroup END
  endif
endif
# turn off bell [[[3
set noerrorbells
set novisualbell
set t_vb=
if exists('&belloff')
  set belloff=all
endif
# better navigation [[[3
set cursorline
set foldmethod=marker
set foldopen+=jump
set foldtext=ben#foldy()
set foldlevelstart=999
set incsearch
set hlsearch
set ignorecase
set smartcase
set scrolloff=4
# set sidescroll=5
set number            # line number
set relativenumber    # relative line number
if has('patch-8.1.1564')
  set signcolumn=number
else
  set signcolumn=yes
endif
if has('mouse')
  set mouse=nv
  set mousehide
endif
# wild stuff [[[3
set suffixes+=.a,.1,.class
set wildignore+=*.o,*.so,*.zip,*.png
set wildmenu
# set wildmode=list:longest,full
# set wildoptions=tagfile
set path+=**
set complete-=i   # disable scanning included files
set complete-=t   # disable searching tags
# set completeopt=longest,menu "preview
set completeopt-=preview
set completeopt+=longest,menuone,noselect
# grep [[[3
&grepprg = 'rg --vimgrep'
&grepformat = '%f:%l:%c:%m'
&errorformat ..= ',%f\|%\s%#%l col%\s%#%c%\s%#\| %m'
# breaking [[[3
set wrap
set nolinebreak
set breakindent
set breakindentopt=min:40

set cpoptions=aABcfFqsZ # -e
set formatoptions=jtcroql
set formatoptions+=m    #允许对multi_byte字符换行（否则默认只能空格或者英文标点，详见set breakat=）
# misc [[[3
set updatetime=300
set autoread
set autowrite              # Automatically save before commands like :next and :make
set wrapscan               # Searches wrap around end-of-file.
set report=0               # Always report changed lines.
set synmaxcol=99999        # Only highlight the first 500 columns.
set history=1000
set backspace=indent,eol,start
set hidden
set nrformats-=octal
set splitbelow
set splitright
set titlestring=VIM:\ %f
set switchbuf=useopen,usetab
set ttyfast
# set lazyredraw
# set timeoutlen=500
# set ttimeoutlen=50
set noshowmode # Hide the mode text (e.g. -- INSERT --)

# diffopt
&diffopt = "internal,filler,closeoff,hiddenoff,algorithm:patience"
nnoremap <silent> [w :let &diffopt = "internal,filler,closeoff,hiddenoff,algorithm:patience"<CR>:echo &diffopt<CR>
nnoremap <silent> ]w :let &diffopt = "internal,filler,closeoff,hiddenoff,algorithm:patience,iwhiteall,iblank"<CR>:echo &diffopt<CR>

#LF
set fileformat=unix
set fileformats=unix,dos

# use old regex engine for better performance
set regexpengine=1

# this makes sure that shell scripts are highlighted
# as bash scripts and not sh scripts
g:is_posix = 1

set cmdheight=1
set langmenu=en_US

if has('sodium') && has("patch-9.0.1481")
  set cryptmethod=xchacha20v2
else
  set cryptmethod=blowfish2
endif

set conceallevel=2
# backup/swap/info/undo settings [[[3
set backup
set backupskip=
set backupext=-vimbackup

set updatecount=100
set undofile
$vimtmp = $HOME .. '/.config/vimtmp/'
for tmp in ['backup', 'swap', 'undo', 'info']
  call mkdir($vimtmp .. tmp, 'p')
endfor

set backupdir=$vimtmp/backup/
set directory=$vimtmp/swap/
set undodir=$vimtmp/undo/
set viminfo='100,n$vimtmp/info/viminfo

# old vim don't have cdhome, ignore error
silent! set cdhome

# ]]]
# ]]]
# ]]]

# vim:fdm=marker:fmr=[[[,]]]:ft=vim
