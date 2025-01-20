vim9script

# set confirm
set hidden
set autoindent shiftwidth=4 softtabstop=-1 expandtab # smarttab
# set cinoptions=>2,l1,p0,)50,*50,t0
set ttimeout ttimeoutlen=25
set ruler
# set belloff=all shortmess=aoOTIc
set belloff=all shortmess=aoOTIc
set display=lastline smoothscroll
set hlsearch incsearch ignorecase smartcase
set wildmenu wildmode=full wildoptions=pum,fuzzy pumheight=20
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,tags,*.cmx,*.cmi
set wildignore+=*~,*.py[co],__pycache__,
set complete-=i # disable scanning included files
set complete-=t # disable searching tags
# set completeopt=menu,longest,menuone,popup,noselect
set completeopt=menu,popup,preview
set completepopup=highlight:Pmenu,border:off
set suffixes+=.a,.1,.class
set path+=**
set cpoptions=aABcfFqsZ # -e
# set breakindentopt=min:40
set wrap breakindent breakindentopt=sbr,list:-1 linebreak nojoinspaces
set fillchars=fold:\ ,vert:│
set virtualedit=block
set backspace=indent,eol,start
set nostartofline
set sidescroll=1 sidescrolloff=3 scrolloff=4
set nrformats=bin,hex,unsigned
set nospell
set number relativenumber cursorline cursorlineopt=number signcolumn=number

set diffopt=vertical,internal,filler,closeoff,indent-heuristic,hiddenoff,algorithm:patience
nnoremap <silent> [w <cmd>set diffopt-=iwhiteall,iblank<BAR>echo &diffopt<CR>
nnoremap <silent> ]w <cmd>set diffopt+=iwhiteall,iblank<BAR>echo &diffopt<CR>
set sessionoptions=buffers,curdir,tabpages,winsize,slash,unix
set viewoptions=cursor,folds,slash,unix

# set mouse=a

# &errorformat ..= ',%f\|%\s%#%l col%\s%#%c%\s%#\| %m'
if executable('rg')
    set grepprg=rg\ -H\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

set history=1000
set updatetime=300
set updatecount=100
set undofile
set backup
# set backupskip=
set backupext=-vimbackup

set backupdir=$vimtmp/backup/
set directory=$vimtmp/swap/
set undodir=$vimtmp/undo/
set viminfo='200,n$vimtmp/info/viminfo
set viewdir=$vimtmp/view

for tmp in ['backup', 'swap', 'undo', 'info', 'view']
  mkdir($vimtmp .. tmp, 'p')
endfor

set laststatus=2
set modeline
set modelines=1
set showcmd
set showmatch
set matchtime=0
set noshowmode # Hide the mode text (e.g. -- INSERT --)

set fileformats=unix,dos
set fileencodings=ucs-bom,utf-8,utf-16le,gbk,big5,gb18030,gb2312,cp936,usc-bom,euc-jp
set encoding=utf-8
scriptencoding utf-8

set list listchars=tab:▸\ ,nbsp:␣,trail:⣿,extends:…,precedes:… showbreak=↪
augroup vimrc
  autocmd InsertEnter * set listchars-=trail:⣿
  autocmd InsertLeave * set listchars+=trail:⣿
augroup END
# const is_tty = !match(&term, 'linux')
# if !is_tty
#   if has('multi_byte') && &encoding ==# 'utf-8'
#     &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
#     &fillchars = 'diff: '  # ▚
#     &showbreak = '↳ '
#     highlight VertSplit ctermfg=242
#     augroup vimrc
#       autocmd InsertEnter * set listchars-=trail:⣿
#       autocmd InsertLeave * set listchars+=trail:⣿
#     augroup END
#   else
#     &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
#     #let &fillchars = 'stlnc:#'
#     &showbreak = '-> '
#     augroup vimrc
#       autocmd InsertEnter * set listchars-=trail:.
#       autocmd InsertLeave * set listchars+=trail:.
#     augroup END
#   endif
# endif

# turn off bell
# set noerrorbells
# set novisualbell
# set t_vb=

# better navigation
# set foldmethod=marker
set foldopen+=jump
# set foldtext=ben#foldy()
set foldlevelstart=999

if has("patch-9.0.1921")
  set jumpoptions=stack
endif

 # Automatically save before commands like :next and :make
set autoread autowrite
set report=0 # Always report changed lines.
# set synmaxcol=99999 # Only highlight the first 500 columns.
set splitbelow splitright
set titlestring=VIM:\ %f
set switchbuf=useopen,usetab
set tabpagemax=50
set nolangremap

# use old regex engine for better performance
# set regexpengine=1

if has('sodium') && has("patch-9.0.1481")
  set cryptmethod=xchacha20v2
else
  set cryptmethod=blowfish2
endif

set conceallevel=2

g:vimsyn_folding = 'f'

g:markdown_fenced_languages = ['html', 'dataviewjs=javascript', 'js=javascript', 'ruby', 'bash=sh', 'python']

# this makes sure that shell scripts are highlighted
# as bash scripts and not sh scripts
g:is_posix = 1

legacy let c_no_comment_fold = 1
legacy let c_comment_strings = 1

g:snips_author = 'Ben Yip'

# vim:fdm=marker:fmr=[[[,]]]:ft=vim
