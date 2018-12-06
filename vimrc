let s:opam_prefix_dir = system('opam config var prefix')
let s:opam_prefix_dir = substitute(s:opam_prefix_dir, '[\r\n]*$', '', '')
let s:opam_share_dir = s:opam_prefix_dir . '/share'
let s:opam_bin_dir = s:opam_prefix_dir . '/bin'
let $PATH .= ':' . s:opam_bin_dir

let g:is_ssh = ($SSH_CONNECTION != "")
let s:is_win = has('win32')
let s:is_tty = !match(&term, 'linux') || !match(&term, 'win32')
let s:is_gvim = has('gui_running')
let s:has_async = has('job') && has('timers') && has('lambda')
let $v = $HOME.(s:is_win ? '\vimfiles' : '/.vim')
" Plug [[[1
" plug#begin [[[2
call plug#begin('$v/bundle')
let g:plug_window  = 'enew'
let g:plug_pwindow = 'vertical rightbelow new'
" ocaml [[[3
Plug '~/.opam/system/share/merlin/vim'
Plug '~/.opam/system/share/ocp-ident/vim'
Plug '~/.opam/system/share/ocp-index/vim'
" general [[[2
Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'junegunn/limelight.vim', { 'for': [ 'markdown', 'rst', 'text'] }
Plug 'junegunn/vim-easy-align',   { 'on': '<plug>(LiveEasyAlign)' }

Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/junkfile.vim'
Plug 'honza/vim-snippets'

Plug 'dyng/ctrlsf.vim'
Plug 'romainl/vim-qf'
Plug 'yegappan/grep'
Plug 'yegappan/greplace'

Plug 'bennyyip/is.vim'
Plug 'markonm/traces.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'justinmk/vim-sneak'

Plug 'hotoo/pangu.vim'
Plug 'iamcco/dict.vim'

Plug 'AndrewRadev/linediff.vim', { 'on': 'Linediff' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'airblade/vim-rooter', { 'on': 'Rooter' }
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
Plug 'nhooyr/neoman.vim'
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
Plug 'vim-voom/VOoM', { 'on': 'Voom' }
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }

Plug 'tommcdo/vim-exchange'
Plug 'tommcdo/vim-ninja-feet'
Plug 'tommcdo/vim-fugitive-blame-ext'
Plug 'tommcdo/vim-fubitive'

" leaderf [[[3
if !(v:version < 704 || v:version == 704 && has("patch330") == 0)
  Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
  Plug 'Yggdroot/LeaderF-marks'
  Plug 'bennyyip/LeaderF-github-stars'
  Plug 'bennyyip/LeaderF-ghq'
endif
" vim 8 [[[3
if s:has_async
  Plug 'maralla/completor.vim'
  Plug 'ludovicchabant/vim-gutentags' " https://github.com/universal-ctags/ctags
endif
Plug 'skywind3000/asyncrun.vim'
Plug 'w0rp/ale'
" *nix stuff [[[ 3
if !s:is_win
  Plug 'benmills/vimux'
  Plug 'christoomey/vim-tmux-navigator'
endif
Plug 'lilydjwg/fcitx.vim'
" look [[[3
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'vim-scripts/lilypink'
Plug 'luochen1990/rainbow'
Plug 'itchyny/vim-cursorword'
" tpope [[[3
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-capslock'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sensible'
" Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" textobj [[[3
Plug 'adriaanzon/vim-textobj-matchit'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter'
" lang [[[2
Plug 'PProvost/vim-ps1'
Plug 'Shiracamus/vim-syntax-x86-objdump-d'
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
Plug 'ekalinin/Dockerfile.vim'
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'tikhomirov/vim-glsl'
Plug 'rust-lang/rust.vim'
Plug 'Firef0x/PKGBUILD.vim'
" python [[[3
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'hdima/python-syntax', { 'for': 'python'}
" typescript [[[3
Plug 'leafgarland/typescript-vim'
" markup [[[3
Plug 'Rykka/riv.vim', { 'for': 'rst' }
Plug 'iamcco/markdown-preview.vim', { 'for': 'markdown', 'on': 'MarkdownPreview' }
Plug 'lervag/vimtex', {'for': 'tex'}
" web [[[3
Plug 'Valloric/MatchTagAlways'
Plug 'lilydjwg/colorizer'
Plug 'mattn/emmet-vim', { 'for': ['xml', 'html', 'css', 'javascript'] }
Plug 'othree/html5.vim', {'for': 'html'}
" plug#end [[[2
call plug#end()
" Setting [[[1
" general settings [[[2
" init [[[3
let g:mapleader        = "\<Space>"
let g:localleader      = "\\"
let g:vimsyn_folding = 'f'
let g:is_bash        = 1
let g:lisp_rainbow   = 1

let g:markdown_fenced_languages = ['vim']

let g:loaded_2html_plugin     = 1
let g:loaded_getscriptPlugin  = 1
let g:loaded_gzip             = 1
let g:loaded_logipat          = 1
" let g:loaded_matchparen       = 1
let g:loaded_rrhelper         = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_tarPlugin        = 1
let g:loaded_vimballPlugin    = 1
let g:loaded_zipPlugin        = 1
" indent settings [[[3
set autoindent
set cinoptions    =>2,l1,p0,)50,*50,t0
" tab stop
set sts=4 sw=4
set expandtab smarttab
" display settings [[[3
set display       =lastline
set laststatus    =2
set list
set modeline
set modelines     =1
set nostartofline
set numberwidth   =1
set shortmess     =aoOTI
set showcmd
set showmatch
set matchtime     =0
set showmode

set fileencoding  =utf-8
set fileencodings =utf-8,gbk,gb18030,gb2312,cp936,usc-bom,euc-jp
set encoding   =utf-8
scriptencoding utf-8


if !s:is_tty
  if s:is_win
    let &listchars = 'tab:▸ ,extends:>,precedes:<,nbsp:.'
    let &showbreak = '-> '
    highlight VertSplit ctermfg=242
    augroup vimrc
      autocmd InsertEnter * set listchars-=trail:⣿
      autocmd InsertLeave * set listchars+=trail:⣿
    augroup END
  elseif has('multi_byte') && &encoding ==# 'utf-8'
    let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
    let &fillchars = 'diff: '  " ▚
    let &showbreak = '↳ '
    highlight VertSplit ctermfg=242
    augroup vimrc
      autocmd InsertEnter * set listchars-=trail:⣿
      autocmd InsertLeave * set listchars+=trail:⣿
    augroup END
  else
    let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
    "let &fillchars = 'stlnc:#'
    let &showbreak = '-> '
    augroup vimrc
      autocmd InsertEnter * set listchars-=trail:.
      autocmd InsertLeave * set listchars+=trail:.
    augroup END
  endif
endif " s:is_ty
" turn off bell [[[3
set noerrorbells
set novisualbell
set t_vb=
" better navigation [[[3
set cursorline
set foldmethod    =marker
set foldopen     +=jump
set foldtext      =ben#foldy()
"set foldlevel=200  " disable auto folding
set incsearch
set hlsearch
set ignorecase
set smartcase
set scrolloff     =4
set sidescroll    =5
set number            " line number
set relativenumber    " relative line number
if has('mouse')
  set mouse=n
  set mousehide
endif
" wild stuff [[[3
set suffixes     +=.a,.1,.class
set wildignore   +=*.o,*.so,*.zip,*.png
set wildmenu
"set wildmode      =list:longest,full
set wildoptions   =tagfile
set path+=**
set complete-=i   " disable scanning included files
set complete-=t   " disable searching tags
" set completeopt=longest,menu "preview
" breaking [[[3
set wrap
set nolinebreak
set breakindent
set breakindentopt=min:40

set cpoptions     =aABcfFqsZ " -e
set formatoptions =tcrqnj
" Change cursor style dependent on mode
if empty($TMUX)
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
else
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
endif
" misc [[[3
set autoread
set autowrite              " Automatically save before commands like :next and :make
set wrapscan               " Searches wrap around end-of-file.
set report=0               " Always report changed lines.
set synmaxcol=200          " Only highlight the first 200 columns.
set history=1000
set backspace=indent,eol,start
set hidden
set nrformats-=octal
set splitbelow
set splitright
set titlestring =VIM:\ %f
set switchbuf=useopen,usetab,newtab
set ttyfast
set lazyredraw
set timeoutlen=500
set ttimeoutlen=50

"LF
set fileformat=unix
set fileformats=unix,dos

" use old regex engine for better performance
set regexpengine=1

" this makes sure that shell scripts are highlighted
" as bash scripts and not sh scripts
let g:is_posix = 1
" backup/swap/info/undo settings [[[3
set backup
set backupskip   =
set updatecount  =100
set undofile
set backupdir   =$v/files/backup/
set backupext   =-vimbackup
set directory   =$v/files/swap/
set undodir     =$v/files/undo/
set viminfo     ='100,n$v/files/info/viminfo
" apperance [[[2
" colorscheme [[[3
set background=dark
colorscheme gruvbox
hi VertSplit guibg=#282828 guifg=#181A1F
let s:colorscheme = get(g:, 'colors_name', 'default')
" Plugin: itchyny/lightline.vim [[[3
" g:lightline[[[4
let g:lightline = {
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left':  [ [ 'mode', 'paste' ], [ 'fugitive', 'filename'] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'asyncrun', 'fileformat', 'fileencoding', 'filetype'] ]
      \ },
      \ 'component_function': {
      \   'modified':     'LightlineModified',
      \   'readonly':     'LightlineReadonly',
      \   'fugitive':     'LightlineFugitive',
      \   'filename':     'LightlineFilename',
      \   'fileformat':   'LightlineFileformat',
      \   'filetype':     'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode':         'LightlineMode',
      \ },
      \ 'component' : {
      \   'asyncrun': '%{g:asyncrun_status}'
      \ },
      \ }
if !s:is_tty
  if s:colorscheme == 'gruvbox'
    let g:lightline.colorscheme = 'gruvbox'
  else
    let g:lightline.colorscheme = 'one'
  endif
  let g:lightline.separator =  { 'left': "\ue0b0", 'right': "\ue0b2" }
  let g:lightline.subseparator = { 'left': "\ue0b1", 'right': "\ue0b3" }
endif

function! LightlineModified() "[[[4
  return &filetype =~# 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! LightlineReadonly() "[[[4
  return &filetype !~? 'help\|vimfiler\|gundo' && &readonly ? (s:is_tty ? 'RO' : "\ue0a2") : ''
endfunction
function! LightlineFilename() "[[[4
  let l:fname = expand('%:~')
  return l:fname ==# '__Tagbar__' ? g:lightline.l:fname :
        \ l:fname =~# '__Gundo\|NERD_tree' ? '' :
        \ &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'denite' ? denite#get_status_sources() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ ('' !=# LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' !=# l:fname ? l:fname : '[No Name]') .
        \ ('' !=# LightlineModified() ? ' ' . LightlineModified() : '')
endfunction
function! LightlineFugitive() "[[[4
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &filetype !~? 'vimfiler' && exists('*fugitive#head')
      let l:mark = ''  " edit here for cool mark
      let l:branch = fugitive#head()
      return l:branch !=# '' ? (s:is_tty ? '' : "\ue0a0 ").l:branch : ''
    endif
  catch
  endtry
  return ''
endfunction
function! LightlineFileformat() "[[[4
  return winwidth(0) > 70 ? &fileformat : ''
endfunction
function! LightlineFiletype() "[[[4
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction
function! LightlineFileencoding() "[[[4
  return winwidth(0) > 70 ? (&fileencoding !=# '' ? &fileencoding : &encoding) : ''
endfunction
function! LightlineMode() "[[[4
  let l:fname = expand('%:t')
  return l:fname ==# '__Tagbar__' ? 'Tagbar' :
        \ l:fname =~# 'NERD_tree' ? 'NERDTree' :
        \ &filetype ==# 'denite' ? 'Denite' :
        \ &filetype ==# 'vimfiler' ? 'VimFiler' :
        \ &filetype ==# 'vimshell' ? 'VimShell' :
        \ lightline#mode()[0]
        "\ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
"hi EndOfBuffer guibg=#282828 guifg=#282828
" other [[[3
if !g:is_ssh && has("termguicolors")
  " fix bug for vim
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum

  " enable true color
  set termguicolors
endif
if exists('g:Gui')
  GuiFont! Inziu Iosevka CL:h16
  let g:GuiWindowFullScreen=1
endif
if !exists('g:vimrc_loaded')
  if s:is_gvim
    "au GUIEnter * set lines=768 columns=1366 " 窗口啓動時自動最大化
    set cmdheight=1
    set langmenu=en_US
    if s:is_win
      set guioptions-=egmrLtT
      "https://github.com/derekmcloughlin/gvimfullscreen_win32
      augroup vimrc
        autocmd GUIEnter * call libcallnr("gvimfullscreen_64.dll", "ToggleFullScreen", 0)
        autocmd GUIEnter * nmap <leader>tf :call libcallnr("gvimfullscreen_64.dll", "ToggleFullScreen", 0)<CR>
      augroup END
      "au GUIEnter * simalt ~x " 窗口啓動時自動最大化
      set guifont=Inziu\ Iosevka\ CL:h12
    else
      set guioptions-=aegimrLtT
      set guifont=Monospace\ 8
    endif
  endif " has
endif " exists(...)
let g:vimrc_loaded=1
" Windows [[[2
if s:is_win
  set pythonthreedll=python36.dll
  let g:netrw_cygwin = 0
  let g:netrw_silent = 1
endif
" Key Mapping [[[1
" misc [[[2
nmap     t= mxHmygg=G`yzt`x
nmap     tj Jx
nmap     tp "+P
nnoremap tl ^vg_
nmap     T :tabnew<cr>

nmap <silent> <F6> :if &previewwindow<Bar>pclose<Bar>elseif exists(':Gstatus')<Bar>exe 'botright Gstatus'<Bar>else<Bar>ls<Bar>endif<CR>
map <F8>    :Make<CR>

inoremap <silent> <C-G><C-T> <C-R>=repeat(complete(col('.'),map(["%Y-%m-%d %H:%M:%S","%a, %d %b %Y %H:%M:%S %z","%Y %b %d","%d-%b-%y","%a %b %d %T %Z %Y"],'strftime(v:val)')+[localtime()]),0)<CR>

" slect what I just pasted
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" quick <C-w>
nnoremap ' <C-w>
if s:is_win || s:is_gvim
  nnoremap <silent><C-h> <C-w>h
  nnoremap <silent><C-j> <C-w>j
  nnoremap <silent><C-k> <C-w>k
  nnoremap <silent><C-l> <C-w>l
endif
" nohl
nmap <silent> <backspace> :nohl<CR>
" run external command
nmap <leader>; :AsyncRun<space>
" edit
inoremap {<CR>          {}<left><CR><ESC>O
inoremap (<CR>          ()<left><CR><ESC>O
" yank
inoremap <silent><C-v>      <C-r>+
xnoremap <silent><C-c>      "+y
nmap     Y                  y$
" vimrc
nnoremap <leader>fed <Esc>:e $MYVIMRC<CR>
nnoremap <leader>v  :so $MYVIMRC<CR>
" keep selection when indent line in visual mode
xnoremap <  <gv
xnoremap >  >gv
" script helper
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)
" quick edit macro  | ["register]<leader>m
nnoremap <leader>em  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
nnoremap Q @q
" quick substitute
vnoremap qs "zy:%s`<C-R>z``g<left><left>
nnoremap qs :%s`<C-R><C-W>``g<left><left>
" get output from python
imap <C-R>c <esc>:let @a=""<CR>:let @a = execute( "py3 print()")<left><left><left>
" Quit
nnoremap <silent><leader>Q :Sayonara!<CR>
nnoremap <silent><leader>q :Sayonara<CR>
let g:sayonara_confirm_quit = 1
" fold
nmap z] zo]z
nmap z[ zo[z
" Windows
if s:is_win
  nnoremap <silent><leader>ex :execute 'AsyncRun explorer' getcwd()<CR>
  nnoremap <leader>ps         :!start powershell<CR>
endif

nnoremap <localleader>j :set ft=javascript<CR>
nnoremap <localleader>h :set ft=html<CR>
" file, buffer, tab [[[2
nnoremap gf :e <cfile><CR>
nnoremap <leader>fs :w<CR>
nnoremap <leader>fq :x<CR>
nnoremap <leader>fy :let @*=substitute(expand("%"), "/", "\\", "g")<CR>:echo "buffer path copied"<CR>
nnoremap <leader>fp :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>:echo "buffer folder path copied"<CR>
nmap     cd         :lcd %:p:h<CR>:echo expand('%:p:h')<CR>

nnoremap <silent><leader><tab> :<C-u>b!#<CR>
" tab [[[3
noremap  <silent><C-tab> :tabprev<CR>
inoremap <silent><C-tab> <ESC>:tabprev<CR>
call ben#map_switch_tab()
" move [[[2
inoremap <M-o>      <C-O>o
inoremap <M-O>      <C-O>O
nnoremap <M-j> gj
nnoremap <M-k> gk
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <left>
inoremap <M-l> <Right>
" Command [[[1
" :Shuffle | Shuffle selected lines [[[2
command! -range Shuffle <line1>,<line2>call ben#shuffle()
" OpenUrl [[[2
command! -nargs=1 OpenURL :call ben#open_url(<q-args>)
nnoremap gx :OpenURL <cfile><CR>
nnoremap gG :OpenURL http://www.google.com/search?q=<cword><CR>
nnoremap gW :OpenURL http://en.wikipedia.org/wiki/Special:Search?search=<cword><CR>
" :A [[[2
command! A call ben#a('e')
command! AV call ben#a('botright vertical split')
nmap <leader>a :A<CR> 
" GenDef [[[2
command! GenDef call ben#gen_def()
nmap <leader>df :GenDef<CR>
" PX: plus x| chmod +x [[[2
command! PX if !empty(expand('%'))
      \|   write
      \|   call system('chmod +x '.expand('%'))
      \|   silent e
      \| else
        \|   echohl WarningMsg
        \|   echo 'Save the file first'
        \|   echohl None
        \| endif
" RFC [[[2
command! -bar -count=0 RFC     :e http://www.ietf.org/rfc/rfc<count>.txt|setl ro noma
" Autocmd [[[1
augroup vimrc
  " go back to where you exited
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif
  " save on focus lost
  autocmd FocusLost * :silent! wa
augroup END
" Plugin Config [[[1
" Plugin: Shougo/neosnippet [[[2
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)
let g:neosnippet#enable_snipmate_compatibility=1
let g:neosnippet#disable_runtime_snippets = {
      \  '_' : 1,
      \ }
let g:neosnippet#snippets_directory = '$v/snippets'
" Plugin: is.vim [[[2
let g:is#do_default_mappings=1
let g:is#auto_nohlsearch=0
map n  nzzzv
map N  Nzzzv
map *  <Plug>(asterisk-z*)zzzv
map g* <Plug>(asterisk-gz*)zzzv
map #  <Plug>(asterisk-z#)zzzv
map g# <Plug>(asterisk-gz#)zzzv
" Plugin: ludovicchabant/vim-gutentags [[[2
set tags=./.tags;,.tags
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_exclude = ['target']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
  silent! call mkdir(s:vim_tags, 'p')
endif
" Plugin: mhinz/vim-startify [[[2
let g:ascii = [
      \"             ________ ++     ________             ",
      \"            /VVVVVVVV\++++  /VVVVVVVV\\           ",
      \"            \VVVVVVVV/++++++\VVVVVVVV/            ",
      \"             |VVVVVV|++++++++/VVVVV/'             ",
      \"             |VVVVVV|++++++/VVVVV/'               ",
      \"            +|VVVVVV|++++/VVVVV/'+                ",
      \"          +++|VVVVVV|++/VVVVV/'+++++              ",
      \"        +++++|VVVVVV|/VVV___++++++++++            ",
      \"          +++|VVVVVVVVVV/##/ +_+_+_+_             ",
      \"            +|VVVVVVVVV___ +/#_#,#_#,\\           ",
      \"             |VVVVVVV//##/+/#/+/#/'/#/            ",
      \"             |VVVVV/'+/#/+/#/+/#/ /#/             ",
      \"             |VVV/'++/#/+/#/ /#/ /#/              ",
      \"             'V/'  /##//##//##//###/              ",
      \"                      ++                          ",
      \"                                                  ",
      \"                                                  ",
      \]
let g:startify_custom_header =
      \ map(g:ascii + ben#quote(), '"   ".v:val')
let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
      \ 'bundle/.*/doc',
      \ '/data/repo/neovim/runtime/doc',
      \ '/Users/mhi/local/vim/share/vim/vim74/doc',
      \ ]
let g:startify_bookmarks = [
      \ { 'c': $MYVIMRC },
      \ ]
let g:startify_transformations = [
      \ ['.*vimrc$', 'vimrc'],
      \ ]
let g:startify_list_order = [
      \ ['   MRU:'],
      \ 'files',
      \ ['   Sessions:'],
      \ 'sessions',
      \ ]
let g:startify_change_to_dir          = 0
let g:startify_change_to_vcs_root     = 1
let g:startify_enable_special         = 0
let g:startify_files_number           = 7
let g:startify_session_dir = $v.'/files/session'
let g:startify_session_autoload       = 0
let g:startify_session_persistence    = 0
let g:startify_update_oldfiles        = 1
let g:startify_use_env                = 1
highlight StartifyHeader guifg='#fabd2f' ctermfg=214
" Plugin: junegunn/limelight.vim [[[2
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
" Plugin: octol/vim-cpp-enhanced-highlight [[[2
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_simple_template_highlight = 0
"slow
let g:cpp_experimental_template_highlight = 1
" Plugin: benmills/vimux [[[2
if !s:is_win
  "let g:VimuxOrientation = "h"
  map <leader>vp :VimuxPromptCommand<CR>
  map <leader>vl :VimuxRunLastCommand<CR>
  map <leader>vi :VimuxInspectRunner<CR>
  map <leader>vz :VimuxZoomRunner<CR>
  map <Leader>vq :VimuxCloseRunner<CR>
  map <Leader>vx :VimuxInterruptRunner<CR>
  function! VimuxSlime()
    call VimuxSendText(@v)
    call VimuxSendKeys('Enter')
  endfunction

  " If text is selected, save it in the v buffer and send that buffer it to tmux
  vmap <LocalLeader>vs "vy :call VimuxSlime()<CR>
endif
" Plugin: christoomey/vim-tmux-navigator [[[2
let g:tmux_navigator_save_on_switch = 2
" Plugin: tpope/vim-fugitive [[[2
augroup vimrc
  autocmd FileType gitcommit wincmd J
augroup end
" Plugin: tpope/vim-vinegar [[[2
" let g:loaded_netrw       = 1
" let g:loaded_netrwPlugin = 1
augroup vimrc
  autocmd FileType netrw setl bufhidden=delete
augroup END
let g:netrw_banner       = 0
let g:netrw_bufsettings  = 'relativenumber'
let g:netrw_keepdir      = 0
let g:netrw_liststyle    = 1
let g:netrw_sort_options = 'i'
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_timefmt = '%H:%M %y-%m-%d'
let g:netrw_sizestyle = 'H'
" Plugin: iamcco/dict.vim [[[2
nmap <silent> <Leader>oy <Plug>DictSearch
xmap <silent> <Leader>oy <Plug>DictVSearch
nmap <silent> <Leader>oY <Plug>DictWSearch
xmap <silent> <Leader>oY <Plug>DictWVSearch
" Plugin: luochen1990/rainbow [[[2
let g:rainbow_active=1
let g:rainbow_conf = {
      \ 'guifgs': ['#458588', '#d79921', '#d3869b', '#fb4934'],
      \ 'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
      \ 'separately': {
      \        'ocaml': {
      \            'parentheses': ['start=/(\*\@!/ end=/)/ fold'],
      \        }
      \ }
      \}
" Plugin: maralla/completor.vim [[[2
let g:completor_racer_binary = '/bin/racer'
let g:completor_tex_omni_trigger = '\\\\(:?'
      \ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
      \ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
      \ . '|hyperref\s*\[[^]]*'
      \ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|(?:include(?:only)?|input)\s*\{[^}]*'
      \ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
      \ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
      \ .')$'

let g:completor_auto_trigger = 1
inoremap <expr> <Tab> ben#tab_or_complete()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Plugin: w0rp/ale [[[2
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1
let g:ale_fix_on_save = 0
let s:general_ale_fixer = [
      \       'trim_whitespace',
      \       'remove_trailing_lines',
      \   ]
let g:ale_fixers = {
      \   'vim': s:general_ale_fixer,
      \   'rust': s:general_ale_fixer + [
      \       'rustfmt',
      \   ],
      \   'c': s:general_ale_fixer + [
      \       'clang-format',
      \   ],
      \   'cpp': s:general_ale_fixer + [
      \       'clang-format',
      \   ],
      \   'python': s:general_ale_fixer + [
      \       'yapf',
      \   ],
      \   'typescript': s:general_ale_fixer + [
      \       'eslint',
      \       'prettier',
      \   ],
      \   'sh': s:general_ale_fixer + [
      \       'shfmt'
      \   ],
      \}
let g:ale_pattern_options = {
      \   '.*\.h': {'ale_enabled': 0},
      \   '.*\.c': {'ale_enabled': 0},
      \   '.*\.cc': {'ale_enabled': 0},
      \   '.*\.cpp': {'ale_enabled': 0},
      \   '.*\.tex': {'ale_enabled': 0},
      \}
let g:ale_sh_shfmt_options = '-i 2'
" override ]s [s
nmap <silent> ]s <Plug>(ale_next_wrap)
nmap <silent> [s <Plug>(ale_previous_wrap)
nmap <silent> <leader>= <Plug>(ale_fix)
nmap <silent> <leader>+ <Plug>(ale_enable_buffer)
" Plugin: vim-easy-align [[[2
xmap <cr> <plug>(LiveEasyAlign)
" Plugin: justinmk/vim-sneak [[[2
let g:sneak#label = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
" Plugin: Yggdroot/LeaderF [[[2
let g:Lf_DefaultExternalTool = 'rg'
let g:Lf_ShortcutF='<leader>ff'
let g:Lf_ShortcutB='gb'
let g:Lf_MruMaxFiles=500
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2"}
if s:colorscheme == 'gruvbox'
  let g:Lf_StlColorscheme = 'gruvbox'
else
  let g:Lf_StlColorscheme = 'one'
endif
let g:Lf_HideHelp = 1
let g:Lf_ShowRelativePath = 1
let g:Lf_CommandMap = {'<ESC>': ['<ESC>', '<C-G>']}
let g:Lf_NormalMap = {
      \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
      \ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
      \ "Mru":    [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
      \ "Tag":    [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
      \ "Function":    [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
      \ "Colorscheme":    [["<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>']],
      \ }
nnoremap <leader>fr :LeaderfMru<CR>
nnoremap <leader>gs :LeaderfStars<CR>
nnoremap <leader>gr :LeaderfGhq<CR>
nnoremap <leader>gt :LeaderfBufTag<CR>
" Plugin: dyng/ctrlsf.vim [[[2
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_mapping = {
      \ 'next': 'n',
      \ 'prev': 'N',
      \ 'vsplit': 'x'
      \ }
let g:ctrlsf_extra_backend_args = {
      \ 'rg': '--hidden'
      \ }

nmap     <leader>sf <Plug>CtrlSFPrompt
vmap     <leader>sf <Plug>CtrlSFVwordPath
nmap     <leader>sn <Plug>CtrlSFCwordPath
nmap     <leader>sp <Plug>CtrlSFPwordPath
nnoremap <leader>so :CtrlSFOpen<CR>
nnoremap <leader>st :CtrlSFToggle<CR>
" Plugin: kana/vim-textobj-user [[[2
call textobj#user#plugin('rust', {
      \         'closure': {
      \         '*sfile*': expand('<sfile>:p'),
      \         'select-a': 'ac',  '*select-a-function*': 's:select_a',
      \         'select-i': 'ic',  '*select-i-function*': 's:select_i'
      \   },
      \ })

function! s:select_a()
  normal! F|

  let l:end_pos = getpos('.')

  normal! f|

  let l:start_pos = getpos('.')
  return ['v', l:start_pos, l:end_pos]
endfunction


function! s:select_i()
  normal! T|

  let l:end_pos = getpos('.')

  normal! t|

  let l:start_pos = getpos('.')

  return ['v', l:start_pos, l:end_pos]
endfunction
" Plugin: skywind3000/asyncrun.vim [[[2
command! -bang -nargs=* -complete=file -bar Make  AsyncRun<bang> -save=1 -program=make -auto=make @ <args>
augroup vimrc
  " open quickfix when something adds to it
  autocmd QuickFixCmdPost * call asyncrun#quickfix_toggle(8, 1)
augroup END
" Plugin: airblade/vim-rooter [[[2
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_manual_only = 1
let g:rooter_use_lcd = 1
let g:rooter_patterns = ['Cargo.toml', 'mix.exs', 'Makefile', '.git/', '.svn/']
nmap <silent> <leader>r :Rooter<CR>
" Plugin: romainl/vim-qf [[[2
let g:qf_mapping_ack_style = 1
nmap <leader>l <Plug>(qf_qf_toggle_stay)
" Plugin: lilydjwg/colorizer [[[2
let g:colorizer_nomap = 1
let g:colorizer_startup = 0
" simnalamburt/vim-mundo [[[2
nnoremap <leader>u :MundoToggle<CR>
" ending [[[1
runtime local.vim
" vim:fdm=marker:fmr=[[[,]]]
