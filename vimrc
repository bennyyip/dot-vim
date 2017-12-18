let s:is_win = has('win32')
let s:is_nvim = has('nvim')
let s:is_tty = !match(&term, 'linux')
let $v = $HOME.(s:is_win ? '\vimfiles' : '/.vim')
" Plug [[[1
" plug#begin [[[2
call plug#begin('$v/bundle')
let g:plug_window  = 'enew'
let g:plug_pwindow = 'vertical rightbelow new'
" general [[[2
if s:is_win
  Plug 'rust-lang/rust.vim'
else
  Plug 'benmills/vimux'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'lilydjwg/fcitx.vim'
endif

Plug 'roxma/nvim-completion-manager'
Plug 'roxma/ncm-clang'
Plug 'roxma/nvim-cm-racer'
if !has('nvim')
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': './install.sh'
    \ }

Plug 'inkarkat/vim-ingo-library'
Plug 'vim-scripts/Mark'
Plug 'vim-scripts/CountJump'

Plug 'AndrewRadev/splitjoin.vim'
Plug 'KabbAmine/vCoolor.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'Yggdroot/LeaderF-marks'
Plug 'dyng/ctrlsf.vim'
Plug 'haya14busa/is.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'honza/vim-snippets'
Plug 'hotoo/pangu.vim'
Plug 'itchyny/vim-cursorword'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'luochen1990/rainbow'
Plug 'mattn/calendar-vim'
Plug 'mattn/webapi-vim' " for :RustPlay
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
Plug 'mtth/scratch.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
Plug 'vim-voom/VOoM', { 'on': 'Voom' }
Plug 'vimwiki/vimwiki'
Plug 'w0rp/ale'
" lang [[[2
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

Plug 'PProvost/vim-ps1'
Plug 'ekalinin/Dockerfile.vim'

Plug 'derekwyatt/vim-scala', { 'for': 'scala' }

Plug 'Rykka/riv.vim', { 'for': 'rst' }
Plug 'iamcco/markdown-preview.vim', { 'for': 'markdown', 'on': 'MarkdownPreview' }
Plug 'iamcco/dict.vim'
Plug 'amix/vim-zenroom2', { 'for': [ 'markdown', 'rst', 'txt'] }
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'hdima/python-syntax', { 'for': 'python'}

Plug 'lilydjwg/colorizer'
Plug 'mattn/emmet-vim', { 'for': ['xml', 'html', 'css', 'javascript'] }
Plug 'Valloric/MatchTagAlways'
Plug 'Valloric/ListToggle'
Plug 'othree/html5.vim', {'for': 'html'}

Plug 'cespare/vim-toml', { 'for': 'toml' }

Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'tikhomirov/vim-glsl'
Plug 'rhysd/vim-clang-format', { 'for': [ 'c', 'cpp' ] }
Plug 'Shiracamus/vim-syntax-x86-objdump-d'
" look [[[2
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
" tpope [[[2
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-capslock'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" junegunn [[[2
Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'junegunn/limelight.vim', { 'for': [ 'markdown', 'rst', 'text'] }
Plug 'junegunn/vim-easy-align',   { 'on': '<plug>(LiveEasyAlign)' }
Plug 'junegunn/vim-peekaboo'
" bennyyip [[[2
" https://github.com/universal-ctags/ctags
Plug 'bennyyip/tagbar', { 'on': 'TagbarToggle' }
Plug 'bennyyip/LeaderF-github-stars'
Plug 'bennyyip/LeaderF-ghq'
Plug 'bennyyip/vim-yapf', { 'for': 'python' }
" plug#end [[[2
call plug#end()
" Setting [[[1
" general settings [[[2
" init [[[3
let mapleader        = "\<Space>"
let localleader      = "\\"
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

set fenc  =utf-8
set fencs =utf-8,gbk,gb18030,gb2312,cp936,usc-bom,euc-jp
set enc   =utf-8

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
    let &showbreak = '↪ '
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
  set mouse=a
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
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
else
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
endif
" misc [[[3
set wrapscan               " Searches wrap around end-of-file.
set report=0               " Always report changed lines.
set synmaxcol=200          " Only highlight the first 200 columns.
set history=1000
set backspace=indent,eol,start
set hidden
set nrformats-=octal
set autoread
set splitbelow
set splitright
set titlestring =VIM:\ %f
set switchbuf=useopen,usetab,newtab
set ttyfast
set lazyredraw

"LF
set fileformat=unix
set fileformats=unix,dos

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
if s:is_nvim
  set shada       ='100
else
  set viminfo     ='100,n$v/files/info/viminfo
endif
" apperance [[[2
" Plugin: itchyny/lightline.vim [[[2
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
  let g:lightline.colorscheme = 'gruvbox'
  let g:lightline.separator =  { 'left': "\ue0b0", 'right': "\ue0b2" }
  let g:lightline.subseparator = { 'left': "\ue0b1", 'right': "\ue0b3" }
endif
function! LightlineModified() "[[[4
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! LightlineReadonly() "[[[4
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? (s:is_tty ? "RO" : "\ue0a2") : ''
endfunction
function! LightlineFilename() "[[[4
  let fname = expand('%:~')
  return fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'denite' ? denite#get_status_sources() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction
function! LightlineFugitive() "[[[4
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? (s:is_tty ? "" : "\ue0a0 ").branch : ''
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
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction
function! LightlineMode() "[[[4
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'denite' ? 'Denite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ lightline#mode()[0]
  "\ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
" tagbar [[[4
let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
  let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction
" Plugin: morhetz/gruvbox [[[3
set bg=dark
colorscheme gruvbox
hi VertSplit guibg=#282828 guifg=#181A1F
"hi EndOfBuffer guibg=#282828 guifg=#282828
" other [[[3
if !exists("g:vimrc_loaded")
  if has("gui_running")
    "au GUIEnter * set lines=768 columns=1366 " 窗口啓動時自動最大化
    set cmdheight=1
    set langmenu=en_US
    if s:is_win
      set go-=egmrLtT
      "https://github.com/derekmcloughlin/gvimfullscreen_win32
      au GUIEnter * call libcallnr("gvimfullscreen_64.dll", "ToggleFullScreen", 0)
      au GUIEnter * nmap <leader>tf :call libcallnr("gvimfullscreen_64.dll", "ToggleFullScreen", 0)<CR>
      "au GUIEnter * simalt ~x " 窗口啓動時自動最大化
      set guifont=Inziu\ Iosevka\ CL:h14
    else
      set go-=aegimrLtT
      set guifont=Monospace\ 16
    endif
  endif " has
endif " exists(...)
let g:vimrc_loaded=1
" setup new tabline, just like %M%t in macvim
" set tabline=%!ben#Vim_NeatTabLine()
" Windows [[[2
if s:is_win
  set pythonthreedll=python36.dll
  let g:netrw_cygwin = 0
  let g:netrw_silent = 1
endif
" Key Mapping [[[1
" misc [[[2
" begins with t [[[3
nmap     t= mxHmygg=G`yzt`x
nmap     tj Jx
nmap     tp "+P
nnoremap tl ^vg_
nmap     T :tabnew<cr>
" file text object [[[3
nmap dae ggdG
nmap cae ggcG
nmap vae ggVG
nmap yae mxHmyggyG`yzt`x
" quick <C-w> [[[3
nnoremap ' <C-w>
if s:is_win
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l
endif
" less style nohl [[[3
nmap <silent> <M-u> :nohls<CR>
" run external command [[[3
nmap <leader>; :AsyncRun<space>
" edit [[[3
inoremap {<CR>          {}<left><CR><ESC>O
inoremap (<CR>          ()<left><CR><ESC>O
" yank [[[3
inoremap <silent><C-v>      <C-r>+
xnoremap <silent><C-c>      "+y
nmap     Y                  y$
" vimrc [[[3
nnoremap <leader>fed <Esc>:e $MYVIMRC<CR>
nnoremap <leader>vr  :so $MYVIMRC<CR>
" keep selection when indent line in visual mode [[[3
xnoremap <  <gv
xnoremap >  >gv
" script helper [[[3
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)
" quick edit macro  | ["register]<leader>m [[[3
nnoremap <leader>em  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
nnoremap Q @q
" quick substitute [[[3
vmap qs "zy:%s`<C-R>z``g<left><left>
" get output from python [[[3
imap <C-R>c <esc>:let @a=""<CR>:let @a = execute( "py3 print()")<left><left><left>
" Quit [[[3
nnoremap <silent><leader>Q :Sayonara!<CR>
nnoremap <silent><leader>q :Sayonara<CR>
inoremap <C-Q> <esc>:Sayonara<cr>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
let g:sayonara_confirm_quit = 1
" fold [[[3
nnoremap <silent><space><space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
vnoremap <silent><space><space> zf
nmap z] zo]z
nmap z[ zo[z
" Windows [[[3
if s:is_win
  nnoremap <silent><leader>ex :execute 'AsyncRun explorer' getcwd()<CR>
  nnoremap <leader>ps         :!start powershell<CR>
endif
" file, buffer, tab[[[2
nnoremap gf :e <cfile><CR>
nnoremap <leader>fs :w<CR>
nnoremap <leader>fq :x<CR>
nnoremap <leader>fy :let @*=substitute(expand("%"), "/", "\\", "g")<CR>:echo "buffer path copied"<CR>
nnoremap <leader>fp :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>:echo "buffer folder path copied"<CR>
nmap     cd         :lcd %:p:h<CR>:echo expand('%:p:h')<CR>
cmap     w!!        w !sudo tee % >/dev/null

nnoremap <silent><leader><tab> :<C-u>b#<CR>
" tab [[[3
noremap  <silent><C-tab> :tabprev<CR>
inoremap <silent><C-tab> <ESC>:tabprev<CR>
imap  <silent><M-1>   <Esc>:tabn 1<cr>i
imap  <silent><M-2>   <Esc>:tabn 2<cr>i
imap  <silent><M-3>   <Esc>:tabn 3<cr>i
imap  <silent><M-4>   <Esc>:tabn 4<cr>i
imap  <silent><M-5>   <Esc>:tabn 5<cr>i
imap  <silent><M-6>   <Esc>:tabn 6<cr>i
imap  <silent><M-7>   <Esc>:tabn 7<cr>i
imap  <silent><M-8>   <Esc>:tabn 8<cr>i
imap  <silent><M-9>   <Esc>:tabn 9<cr>i
imap  <silent><M-0>   <Esc>:tabn 10<cr>i
noremap  <silent><M-1>   :tabn 1<cr>
noremap  <silent><M-2>   :tabn 2<cr>
noremap  <silent><M-3>   :tabn 3<cr>
noremap  <silent><M-4>   :tabn 4<cr>
noremap  <silent><M-5>   :tabn 5<cr>
noremap  <silent><M-6>   :tabn 6<cr>
noremap  <silent><M-7>   :tabn 7<cr>
noremap  <silent><M-8>   :tabn 8<cr>
noremap  <silent><M-9>   :tabn 9<cr>
noremap  <silent><M-0>   :tabn 10<cr>
inoremap <silent><M-1>   <ESC>:tabn 1<cr>
inoremap <silent><M-2>   <ESC>:tabn 2<cr>
inoremap <silent><M-3>   <ESC>:tabn 3<cr>
inoremap <silent><M-4>   <ESC>:tabn 4<cr>
inoremap <silent><M-5>   <ESC>:tabn 5<cr>
inoremap <silent><M-6>   <ESC>:tabn 6<cr>
inoremap <silent><M-7>   <ESC>:tabn 7<cr>
inoremap <silent><M-8>   <ESC>:tabn 8<cr>
inoremap <silent><M-9>   <ESC>:tabn 9<cr>
inoremap <silent><M-0>   <ESC>:tabn 10<cr>
" move [[[2
nnoremap <M-j> gj
nnoremap <M-k> gk
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <left>
inoremap <M-l> <Right>
" Function and Command [[[1
" :Root | Change directory to the root of the Git repository [[[2
function! s:root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    echo 'Not in git repo'
  else
    execute 'lcd' root
    echo 'Changed directory to: '.root
  endif
endfunction
command! Root call s:root()
" :Shuffle | Shuffle selected lines [[[2
function! s:shuffle() range
  ruby << RB
  first, last = %w[a:firstline a:lastline].map { |e| VIM::evaluate(e).to_i }
  (first..last).map { |l| $curbuf[l] }.shuffle.each_with_index do |line, i|
  $curbuf[first + i] = line
end
RB
endfunction
command! -range Shuffle <line1>,<line2>call s:shuffle()
" :duck | Search DuckDuckGo.com [[[2
function! s:duck()
endfunction

function! s:duck(pat)
  let q = substitute(a:pat, '["\n]', ' ', 'g')
  " let q = substitute(q, '[[:punct:] ]',
  "       \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
  let q =' "https:\\/\\/www.duckduckgo.com\\/?q='.q.'"'
  let o = (s:is_win ? 'explorer' : 'xdg-open') . q
  echo o
  execute 'AsyncRun' o
endfunction

command! -nargs=1 Duck call <SID>duck(<q-args>)
nnoremap <silent><leader>? :call <SID>duck(expand("<cWORD>"))<cr>
xnoremap <silent><leader>? "gy:call <SID>duck(@g)<cr>gv
" :A [[[2
function! s:a(cmd)
  let name = expand('%:r')
  let ext = tolower(expand('%:e'))
  let sources = ['c', 'cc', 'cpp', 'cxx']
  let headers = ['h', 'hh', 'hpp', 'hxx']
  for pair in [[sources, headers], [headers, sources]]
    let [set1, set2] = pair
    if index(set1, ext) >= 0
      for h in set2
        let aname = name.'.'.h
        for a in [aname, toupper(aname)]
          if filereadable(a)
            execute a:cmd a
            return
          end
        endfor
      endfor
    endif
  endfor
endfunction
command! A call s:a('e')
command! AV call s:a('botright vertical split')
nmap <leader>a :A<CR>

function! s:gen_def()
  normal 0yf;
  call s:a('e')
  normal Go
  normal p;cl {
  normal o}
  normal O
  normal cc
endfunction
command! GenDef call s:gen_def()
nmap <leader>df :GenDef<CR>
" EX | chmod +x [[[2
command! EX if !empty(expand('%'))
      \|   write
      \|   call system('chmod +x '.expand('%'))
      \|   silent e
      \| else
        \|   echohl WarningMsg
        \|   echo 'Save the file first'
        \|   echohl None
        \| endif
" Generate .clang_complete base on makefile [[[2
command! GenClangComplete AsyncRun make clean && make CC='$v/bin/cc_args.py gcc'
" Autocmd [[[1
" go back to where you exited [[[2
autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal g'\"" |
      \ endif
" save on focus lost [[[2
au FocusLost * :wa
" auto trim spaces [[[2
au BufWritePre * TrimSpaces
au FileAppendPre * TrimSpaces
au FileWritePre * TrimSpaces
au FilterWritePre * TrimSpaces
" Plugin Config [[[1
" Plugin: Shougo/neosnippet [[[2
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)
let g:neosnippet#enable_snipmate_compatibility=1
" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \  "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

let g:neosnippet#disable_runtime_snippets = {
      \  '_' : 1,
      \ }
let g:neosnippet#snippets_directory = '$v/snippets'
" Plugin: is.vim [[[2
map n  <Plug>(is-n)zzzv
map N  <Plug>(is-N)zzzv
map *  <Plug>(asterisk-z*)<Plug>(is-nohl-2) zzzv
map g* <Plug>(asterisk-gz*)<Plug>(is-nohl-2)zzzv
map #  <Plug>(asterisk-z#)<Plug>(is-nohl-2) zzzv
map g# <Plug>(asterisk-gz#)<Plug>(is-nohl-2)zzzv
" Plugin: majutsushi/tagbar [[[2
let g:tagbar_type_tex = {
      \ 'ctagstype' : 'latex',
      \ 'kinds'  : [
      \ 's:sections',
      \ 'g:graphics:1',
      \ 'l:labels:1',
      \ 'r:refs:1',
      \ 'p:pagerefs:1'
      \ ],
      \ 'sort'  : 0
      \ }

let g:tagbar_type_nc = {
      \ 'ctagstype' : 'nesc',
      \ 'kinds'  : [
      \ 'd:definition',
      \ 'f:function',
      \ 'c:command',
      \ 'a:task',
      \ 'e:event'
      \ ],
      \ }

let g:tagbar_width = 30
nmap tb :TagbarToggle<cr>
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
nnoremap <leader>st :Startify<cr>
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
    call VimuxSendKeys("Enter")
  endfunction

  " If text is selected, save it in the v buffer and send that buffer it to tmux
  vmap <LocalLeader>vs "vy :call VimuxSlime()<CR>
endif
" Plugin: christoomey/vim-tmux-navigator [[[2
let g:tmux_navigator_save_on_switch = 2
" Plugin: netrw [[[2
" let g:loaded_netrwPlugin = 1
let g:netrw_banner       = 0
let g:netrw_bufsettings  = 'relativenumber'
let g:netrw_keepdir      = 0
let g:netrw_liststyle    = 1
let g:netrw_sort_options = 'i'
" Plugin: justinmk/vim-dirvish [[[2
nnoremap <silent><leader>ft :vsplit +Dirvish<cr><c-w>H<c-w>35<bar>
nnoremap <silent><leader>fT :vsplit <cr>:Dirvish %<cr><c-w>H<c-w>35<bar>
augroup my_dirvish_events
  autocmd!
  " Map t to "open in new tab".
  autocmd FileType dirvish
        \  nnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
        \ |xnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>

  " Enable :Gstatus and friends.
  autocmd FileType dirvish call fugitive#detect(@%)

  " Map `gr` to reload the Dirvish buffer.
  autocmd FileType dirvish nnoremap <silent><buffer> gr :<C-U>Dirvish %<CR>

  " Map `gh` to hide dot-prefixed files.
  " To "toggle" this, just press `R` to reload.
  " autocmd FileType dirvish nnoremap <silent><buffer>
  "       \ gh :silent keeppatterns g@\v[/\\]\.[^\\/]+[\\/]?$@d<CR>

  " Auto hide dotfiles, press "u" to show
  autocmd FileType dirvish silent keeppatterns g@\v[/\\]\.[^\\/]+[\\/]?$@d_

  autocmd FileType dirvish nmap <buffer> <c-o> -
  " double "space" to preview
  autocmd FileType dirvish nmap <silent><buffer> <space><space> p<C-w>p
augroup END
" Plugin: bennyyip/dict.vim [[[2
nmap <silent> <Leader>oy <Plug>DictSearch
xmap <silent> <Leader>oy <Plug>DictVSearch
nmap <silent> <Leader>oY <Plug>DictWSearch
xmap <silent> <Leader>oY <Plug>DictWVSearch

" Plugin: luochen1990/rainbow [[[2
let g:rainbow_active=1
let g:rainbow_conf = {
      \ 'guifgs': ['#458588', '#d79921', '#d3869b', '#fb4934'],
      \ 'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
      \}
" Plugin: maralla/completor.vim [[[2
inoremap <expr> <tab>    ben#tab_yeah("\<c-n>", "\<tab>")
inoremap <expr> <s-tab> ben#tab_yeah("\<c-p>", "\<s-tab>")
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
" Plugin: w0rp/ale [[[2
let g:ale_tex_lacheck_executable="shutup" "shutup is a program that do nothing, mute lacheck
" Plugin: vim-easy-align [[[2
xmap <cr> <plug>(LiveEasyAlign)
" Plugin justinmk/vim-sneak [[[2
let g:sneak#label = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
" Plugin Valloric/ListToggle [[[2
let g:lt_location_list_toggle_map = '<leader>ol'
let g:lt_quickfix_list_toggle_map = '<leader>l'
" Plugin vimwiki/vimwiki [[[2
let g:vimwiki_list = [{'template_deafult': 'default' }]
" Plugin Yggdroot/LeaderF [[[2
let g:Lf_ShortcutF='<leader>ff'
let g:Lf_ShortcutB='gb'
let g:Lf_MruMaxFiles=500
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2" }
nnoremap <leader>fr :LeaderfMru<CR>
nnoremap <leader>gs :LeaderfStars<CR>
nnoremap <leader>gr :LeaderfGhq<CR>
let g:Lf_StlColorscheme = 'gruvbox'
" Plugin dyng/ctrlsf.vim [[[2
let g:ctrlsf_default_root = 'project+fw'
let g:ctrlsf_mapping = {
      \ "next": "n",
      \ "prev": "N",
      \ "vsplit": "x"
      \ }
com! -n=* -comp=customlist,ctrlsf#comp#Completion Rg call ctrlsf#Search(<q-args>)
command! Rgt CtrlSFToggle
command! Rgu CtrlSFUpdate
" Plugin mtth/scratch.vim [[[2
let g:scratch_no_mappings = 1
nmap gs <plug>(scratch-insert-reuse)
xmap gs <plug>(scratch-selection-reuse)
xmap gS <plug>(scratch-selection-clear)
" Plugin CountJump [[[2
call CountJump#TextObject#MakeWithCountSearch('', '/', 'ai', 'v', '\\\@<!/', '\\\@<!/') " js regex
call CountJump#TextObject#MakeWithCountSearch('', 'c', 'ai', 'v', '\\\@<!|', '\\\@<!|') " Rust closure
call CountJump#TextObject#MakeWithCountSearch('', ':', 'ai', 'v', '\\\@<!:', '\\\@<!:')
" ending [[[1
runtime local.vim
" vim:fdm=marker:fmr=[[[,]]]
