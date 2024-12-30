vim9script
# Setting [[[1
const is_tty = !match(&term, 'linux')
# general settings [[[2
set nocompatible
syntax on # turn on syntax highlighting
filetype plugin indent on
# init [[[3
g:mapleader = "\<Space>"
g:localleader = "\\"
g:vimsyn_folding = 'f'
g:markdown_fenced_languages = ['html', 'js=javascript', 'ruby', 'bash=sh', 'python']

legacy let c_no_comment_fold = 1
legacy let c_comment_strings = 1
# indent settings [[[3
set autoindent
# set cinoptions=>2,l1,p0,)50,*50,t0
# Don't mess with 'tabstop', with 'expandtab' it isn't used.
# Instead set softtabstop=-1, then 'shiftwidth' is used.
set smarttab expandtab shiftwidth=4 softtabstop=-1
# display settings [[[3
set display=lastline smoothscroll
set laststatus=2
set list
set modeline
set modelines=1
set nostartofline
set numberwidth=1
set showcmd
set showmatch
set matchtime=0
set showmode
set ruler

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
set belloff=all shortmess=aoOTIc
# better navigation [[[3
set foldmethod=marker
set foldopen+=jump
set foldtext=ben#foldy()
set foldlevelstart=999
set hlsearch incsearch ignorecase smartcase
set scrolloff=4
set sidescroll=1 sidescrolloff=3
set number relativenumber cursorline cursorlineopt=number signcolumn=number
if has('mouse')
  set mouse=a
  # set mouse=nv
  # set mousehide
endif
if has("patch-9.0.1921")
  set jumpoptions=stack
endif
# wild stuff [[[3
set suffixes+=.a,.1,.class
set wildmenu wildmode=longest:full,full wildoptions=pum,fuzzy pumheight=20
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,tags
set wildignore+=*~,*.py[co],__pycache__,
set path+=**
set complete-=i   # disable scanning included files
set complete-=t   # disable searching tags
# set completeopt=menu,popup,fuzzy completepopup=highlight:Pmenu
set completeopt=menu,longest,menuone,popup,noselect
set completepopup=highlight:Pmenu
set completepopup+=border:off
# grep [[[3
&grepprg = 'rg --vimgrep --no-heading -H'
&grepformat = '%f:%l:%c:%m'
&errorformat ..= ',%f\|%\s%#%l col%\s%#%c%\s%#\| %m'
# breaking [[[3
set wrap breakindent breakindentopt=sbr,list:-1 linebreak nojoinspaces
# set breakindentopt=min:40

set cpoptions=aABcfFqsZ # -e
set formatoptions=jtcroql
set formatoptions+=m    #允许对multi_byte字符换行（否则默认只能空格或者英文标点，详见set breakat=）
# misc [[[3
set nospell
set virtualedit=block
set updatetime=300
set autoread
set autowrite              # Automatically save before commands like :next and :make
set wrapscan               # Searches wrap around end-of-file.
set report=0               # Always report changed lines.
set synmaxcol=99999        # Only highlight the first 500 columns.
set history=1000
set backspace=indent,eol,start
set hidden
set nrformats=bin,hex,unsigned
set splitbelow
set splitright
set titlestring=VIM:\ %f
set switchbuf=useopen,usetab
set ttyfast
# set lazyredraw
set ttimeout ttimeoutlen=25
# set timeoutlen=250
set noshowmode # Hide the mode text (e.g. -- INSERT --)
set tabpagemax=50
set sessionoptions=buffers,curdir,tabpages,winsize,slash,unix
set viewoptions=cursor,folds,slash,unix
set nolangremap

# diffopt
# &diffopt = "internal,filler,closeoff,hiddenoff,algorithm:patience"
set diffopt+=vertical,algorithm:histogram,indent-heuristic
nnoremap <silent> [w :let &diffopt = "internal,filler,closeoff,hiddenoff,algorithm:patience"<CR>:echo &diffopt<CR>
nnoremap <silent> ]w :let &diffopt = "internal,filler,closeoff,hiddenoff,algorithm:patience,iwhiteall,iblank"<CR>:echo &diffopt<CR>

#LF
set fileformat=unix fileformats=unix,dos

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
for tmp in ['backup', 'swap', 'undo', 'info', 'view']
  call mkdir($vimtmp .. tmp, 'p')
endfor

set backupdir=$vimtmp/backup/
set directory=$vimtmp/swap/
set undodir=$vimtmp/undo/
set viminfo='200,n$vimtmp/info/viminfo
set viewdir=$vimtmp/view

# ]]]
# ]]]
# ]]]
# vim:fdm=marker:fmr=[[[,]]]:ft=vim
