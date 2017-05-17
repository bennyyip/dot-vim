" plugin List [[[1
call plug#begin('~/.vim/bundle') " vim-plug 初始化
" Enhancement [[[2
Plug 'AndrewRadev/splitjoin.vim'
Plug 'KabbAmine/vCoolor.vim'
" Depends on Ripgrep
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neoyank.vim'
Plug 'Jagua/vim-denite-ghq'
Plug 'bennyyip/denite-github-stars'
"Plug 'MattesGroeger/vim-bookmarks'
Plug 'w0rp/ale'
Plug 'Yggdroot/indentLine'
Plug 'cohama/lexima.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'honza/vim-snippets'
Plug 'junegunn/goyo.vim', { 'for': [ 'markdown', 'rst', 'txt'] }
Plug 'junegunn/limelight.vim'
Plug 'justinmk/vim-sneak'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'luochen1990/rainbow'
" Depends on ctags
" https://github.com/universal-ctags/ctags
Plug 'bennyyip/tagbar'
if has("nvim")
  Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/echodoc.vim'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'zchee/deoplete-jedi'
  Plug 'rust-lang/rust.vim'
else
  Plug 'maralla/completor-neosnippet'
  Plug 'maralla/completor.vim'
endif
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'skywind3000/asyncrun.vim'
"Plug 'takac/vim-hardtime'
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-smooth-scroll'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'vimers/vim-youdao'
Plug 'lilydjwg/fcitx.vim'
Plug 'benmills/vimux'
"]]]
" Language [[[2
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'PProvost/vim-ps1'
Plug 'Rykka/riv.vim', { 'for': 'rst' }
Plug 'Valloric/MatchTagAlways', { 'for': 'html' }
Plug 'amix/vim-zenroom2', { 'for': [ 'markdown', 'rst', 'txt'] }
Plug 'lilydjwg/colorizer'
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'ekalinin/Dockerfile.vim'
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'hdima/python-syntax', { 'for': 'python'}
Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'javascript'] }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'rhysd/vim-clang-format'
Plug 'tikhomirov/vim-glsl'
Plug 'othree/html5.vim', {'for': 'html'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'Shiracamus/vim-syntax-x86-objdump-d'
Plug 'racer-rust/vim-racer', {'for': 'rust'}
"]]]
" Apperance [[[2
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'mhinz/vim-startify'
"]]]
call plug#end()
"]]]
" set [[[1
" general settings [[[2
syntax on
filetype on
filetype plugin on
filetype indent on

call system('mkdir /tmp/.vim-undodir/')
let &undodir = '/tmp/.vim-undodir'

set so=10
set number
set rnu " 相對行號

set undofile

set path+=**

set ignorecase
set smartcase
set hlsearch

set nrformats-=octal

" turn off bell
set vb t_vb=

set wildmenu
set autoread
set formatoptions+=j " Delete comment char when joining lines

"set list lcs=tab:\|\

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
set completeopt=longest,menu " preview
set hidden

"按縮進或手動摺疊
"augroup vimrc
"  au BufReadPre * setlocal foldmethod=indent
"  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
"augroup END
"set foldcolumn=0 "設置摺疊區域的寬度
"set foldlevelstart=200
set foldlevel=200  " disable auto folding
" ]]]
" apperance [[[2
colorscheme gruvbox
set bg=dark

if !exists("g:vimrc_loaded")
  if has("gui_running")
    "au GUIEnter * set lines=768 columns=1366 " 窗口啓動時自動最大化
    set cmdheight=1
    set guioptions-=T "隱藏工具欄
    set guioptions-=L
    set guioptions-=r
    set guioptions-=m
    set langmenu=en_US
    if has('win32') || has('win64')
      au GUIEnter * simalt ~x " 窗口啓動時自動最大化
      set guifont=Inziu\ Iosevka\ CL:h14
    else
      set guifont=Monospace\ 16
    endif

  endif " has
endif " exists(...)
"]]]
" Windows [[[1
if has('win32') || has('win64')
  set pythonthreedll=python36.dll
endif
"]]]
"map[[[1
" leader [[[2
let mapleader = "\<Space>"
" Reload .vimrc [[[3
nnoremap <leader>vr :so $MYVIMRC<CR>
" Buffer [[[3
nnoremap <silent> <leader><tab> :<C-u>b#<CR>
nnoremap <leader>bb :<C-u>Denite buffer<CR>
nnoremap <C-left> :bn<CR>
nnoremap <C-right> :bp<CR>
" File [[[3
nnoremap <leader>fed <Esc>:e $MYVIMRC<CR>
nnoremap <leader>fs :w<CR>
nnoremap <leader>fq :x<CR>
nnoremap <leader>fE :<C-u>w !sudo tee %<CR>
nnoremap <leader>w :w<CR>
" Copy path
nnoremap <leader>fn :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
nnoremap <leader>fp :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>
" Youdao [[[3
nnoremap <leader>oy :<C-u>Dic<CR>
" 用空格鍵來開關摺疊 [[[3
nnoremap <space><space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
vnoremap <space><space> zf
" 中文字數統計 [[[3
nnoremap <leader>wc :%s/[\u4E00-\u9FCC]//gn<CR>
" 全部字符統計：g<C-g>
" Windows [[[3
nnoremap <leader>ex :!start explorer %:p:h<CR>
nnoremap <leader>ps :!start powershell<CR>
" resolve vcs conflict (depends on tpope/vim-unimpaired) [[[3
map <leader>dg1 ]nd]n[ndd[ndd
map <leader>dg2 d]ndd]ndd
" Valloric/MatchTagAlways [[[3
nnoremap <leader>% :MtaJumpToOtherTag<cr>
" benmills/vimux [[[3
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
" Quit [[[3
nnoremap <leader>Q :q!<CR>
nnoremap <leader>q :q<CR>
"     t 开头 [[[2
nmap t= mxHmygg=G`yzt`x
nmap ta ggVG
"     less style 清除高亮
nmap <silent> <M-u> :nohls<CR>
nmap tj Jx
nnoremap tl ^vg_
nmap <silent> to :call append('.', '')<CR>j
nmap <silent> tO :call append(line('.')-1, '')<CR>k
nmap tp "+P
"   g[jk] [[[2
nmap <M-j> gj
nmap <M-k> gk
vmap <M-j> gj
nmap <M-k> gk
"     上下移动一行文字[[[2
nmap <C-j> mz:m+<cr>`z
nmap <C-k> mz:m-2<cr>`z
vmap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z
" 插入模式移动光标 alt + 方向键 [[[2
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <left>
inoremap <M-l> <Right>
set pastetoggle=<F11>
" 其它 [[[2
nmap T :tabnew<cr>
nmap ' <C-W>
nmap Y y$
nmap :; :AsyncRun<space>
nmap :: :!<space>
inoremap <silent> <C-BS> <C-w>
cnoremap <C-a> <home>
cnoremap <C-e> <end>
" Goodbye Ex mode
nnoremap Q gq
" unix2dos
nmap d<CR> :%s/\r//ge<CR>
" Quickfix
nnoremap <leader>oe :copen<CR>
nmap cd :lcd %:p:h<CR>:echo expand('%:p:h')<CR>
"autocmd [[[1
" go back to where you exited [[[2
autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal g'\"" |
      \ endif
" script healper [[[2
au BufNewFile *.py call s:ScriptHeader()
au BufNewFile *.sh call s:ScriptHeader()
au FileType vue syntax sync minlines=500

function! s:ScriptHeader()
  if &filetype == 'python'
    let header = "#!/usr/bin/env python3"
    let coding = "# -*- coding:utf-8 -*-"
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
    call append(3, cfg)
  endif
  normal ''
endfunction

" auto trim spaces [[[2
function! TrimSpaces()
  if !&binary && &filetype != 'diff' && &filetype != 'markdown'
    normal mxHmy
    %s/\s\+$//e
    normal `yzt`x
  endif
endfunction

command! TrimSpaces call TrimSpaces()

"au * ShowSpaces
au BufWritePre * TrimSpaces
au FileAppendPre * TrimSpaces
au FileWritePre * TrimSpaces
au FilterWritePre * TrimSpaces

" noplaintext [[[2
"]]]
"plugin config [[[1
"lightline [[[2
set laststatus=2

"g:lightline[[[3
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename'] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'asyncrun', 'fileformat', 'fileencoding', 'filetype'] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightlineModified',
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \ },
      \ 'component' : {
      \   'asyncrun': '%{g:asyncrun_status}'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

function! LightlineModified() "[[[3
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! LightlineReadonly() "[[[3
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? "\ue0a2" : ''
endfunction
function! LightlineFilename() "[[[3
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
function! LightlineFugitive() "[[[3
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? "\ue0a0 ".branch : ''
    endif
  catch
  endtry
  return ''
endfunction
function! LightlineFileformat() "[[[3
  return winwidth(0) > 70 ? &fileformat : ''
endfunction
function! LightlineFiletype() "[[[3
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction
function! LightlineFileencoding() "[[[3
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction
function! LightlineMode() "[[[3
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'denite' ? 'Denite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ lightline#mode()[0]
  "\ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
"tagbar [[[3
let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
  let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction
"denite [[[2
hi link deniteMatchedChar IncSearch
hi link deniteMatchedRange IncSearch

"let g:denite_force_overwrite_statusline = 1
" Ripgrep for file_rec
call denite#custom#var('file_rec', 'command',
      \ ['rg', '--files', ''])
" Ripgrep command on grep source
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
      \ ['--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
" Change default prompt
call denite#custom#option('default', 'prompt', '>')
" Change ignore_globs
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])
" Sort behavior
call denite#custom#source(
      \ 'file_rec', 'sorters', ['sorter_sublime'])
let dgs#username='bennyyip'

function! s:denite_file_rec_with_path()
  let path = input('path: ', '', 'dir')
  if path != ''
    exec "Denite file_rec -path=" . path
  endif
endfunction

function! s:denite_file_with_path()
  let path = input('path: ', '', 'dir')
  if path != ''
    exec "Denite file -path=" . path
  endif
endfunction

" Key mapping(u for unite, predecessor of denite)
nmap <silent> <leader>u+ :Denite -resume -immediately  -select=+1<CR>
nmap <silent> <leader>u- :Denite -resume -immediately  -select=-1<CR>
nmap <silent> <leader>uR :Denite -resume<CR>
nmap <silent> <leader>ub :Denite -no-statusline buffer<CR>
nmap <silent> <leader>ug :Denite -no-statusline grep<CR>
nmap <silent> <leader>uw :DeniteCursorWord -no-statusline grep<CR><CR>
nmap <silent> <leader>uj :Denite -no-statusline line<CR>
nmap <silent> <leader>ut :Denite -no-statusline filetype<CR>
nmap <silent> <leader>uy :Denite -no-statusline neoyank<CR>
nmap <silent> <leader>u; :Denite -no-statusline command_history<CR>
nmap <silent> <leader>ur :Denite -no-statusline register<CR>
nmap <silent> <leader>fF :Denite -no-statusline file<CR>
nmap <silent> <leader>ff :Denite -no-statusline file_rec<CR>
nmap <silent> <leader>FF :call <SID>denite_file_with_path()<CR>
nmap <silent> <leader>Ff :call <SID>denite_file_rec_with_path()<CR>
nmap <silent> <leader>fr :Denite file_mru<CR>
nmap <silent> <leader>og :Denite -no-statusline github_stars<CR>

"nerdtree [[[2
map nt :NERDTreeToggle<cr>
nmap nT :NERDTreeFind<cr>
" nmap nT :NERDTreeTabsToggle<cr>
let NERDTreeShowBookmarks=0
let NERDTreeMouseMode=2

" swap o and go
let g:NERDTreeMapActivateNode = 'go'
let g:NERDTreeMapPreview = 'o'

" let g:nerdtree_tabs_focus_on_files=1
" let g:nerdtree_tabs_open_on_gui_startup=0

let NERDTreeWinSize=25
let NERDTreeIgnore = ['\.pyc$','\.exe$']
let NERDTreeMinimalUI=0
let NERDTreeDirArrows=1

"let g:newrw_ftp_cmd = 'lftp'
let g:netrw_altv          = 1
let g:netrw_fastbrowse    = 2
let g:netrw_keepdir       = 1
let g:netrw_liststyle     = 3
let g:netrw_retmap        = 1
let g:netrw_silent        = 1
let g:netrw_special_syntax= 1
let g:netrw_browse_split = 3
let g:netrw_banner = 0

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"> How can I open NERDTree automatically when vim starts up on opening a directory?

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"Yggdroot/indentLine [[[2
let g:indentLine_noConcealCursor=""
"LanguageClient [[[2
if has("nvim")
  let g:LanguageClient_serverCommands = {
        \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
        \ }
  " Automatically start language servers.
  let g:LanguageClient_autoStart = 1
endif
"maralla/completor.vim [[[2
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
if !has("nvim")
  let g:completor_gocode_binary = '/home/ben/go/bin/gocode'
  let g:completor_clang_binary = '/usr/bin/clang'
  let g:completor_python_binary = '/usr/bin/python'
  let g:completor_racer_binary = '/usr/bin/racer'
endif
"Shougo/deoplete.nvim [[[2
if has("nvim")
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_smart_case = 1
endif
" neosnippet [[[2
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)

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
let g:neosnippet#snippets_directory = '~/.vim/snippets'
" haya13busa/incsearch.vim [[[2
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
" :h g:incsearch#auto_nohlsearch
"let g:incsearch#auto_nohlsearch = 1
" majutsushi/tagbar [[[2
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

"junegunn/goyo.vim [[[2
nnoremap <silent> <leader>z :Goyo<cr>
"autocmd! User GoyoEnter Limelight
"autocmd! User GoyoLeave Limelight!

"junegunn/limelight.vim [[[2
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
      \ "AllowShortIfStatementsOnASingleLine" : "true",
      \ "AlwaysBreakTemplateDeclarations" : "true",
      \ "Standard" : "C++11" }
" octol/vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_simple_template_highlight = 0
"slow
let g:cpp_experimental_template_highlight = 1

command! GenClangComplete AsyncRun make clean && make CC='~/.vim/bin/cc_args.py gcc'
"luochen1990/rainbow [[2
let g:rainbow_active=1
let g:rainbow_conf = {
      \	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
      \	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
      \	'operators': '_,_',
      \	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
      \	'separately': {
      \		'*': {},
      \		'tex': {
      \			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
      \		},
      \		'lisp': {
      \			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
      \		},
      \		'vim': {
      \			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
      \		},
      \		'html': {
      \			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
      \		},
      \		'css': 0,
      \	}
      \}
"end [[[1
" vim:fdm=marker:fmr=[[[,]]]
