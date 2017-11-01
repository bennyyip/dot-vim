let s:is_win = has('win32')
let $v = $HOME.(s:is_win ? '\vimfiles' : '/.vim')
" Plug [[[1
" plug#begin [[[2
call plug#begin('$v/bundle')
let g:plug_window  = 'enew'
let g:plug_pwindow = 'vertical rightbelow new'
" misc [[[2
Plug 'hotoo/pangu.vim'
Plug 'maralla/completor-neosnippet'
Plug 'maralla/completor.vim'
Plug 'racer-rust/vim-racer', {'for': 'rust'}
let g:racer_experimental_completer = 1
if s:is_win
  Plug 'rust-lang/rust.vim'
else
  Plug 'benmills/vimux'
  Plug 'wellle/tmux-complete.vim'
  Plug 'christoomey/vim-tmux-navigator'
endif

Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim'

Plug 'mattn/webapi-vim' " for :RustPlay
Plug 'mtth/scratch.vim'
Plug 'vimers/vim-youdao'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Jagua/vim-denite-ghq'
Plug 'KabbAmine/vCoolor.vim'
Plug 'haya14busa/is.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'honza/vim-snippets'
Plug 'itchyny/vim-cursorword'
Plug 'lilydjwg/fcitx.vim'  " FIXME: fcitx plugin is the slowest plugin
Plug 'luochen1990/rainbow'
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
Plug 'skywind3000/asyncrun.vim'
Plug 'w0rp/ale'
Plug 'vim-scripts/Mark'
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'vim-voom/VOoM', { 'on': 'Voom' }
" lang [[[2
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'bennyyip/vim-yapf', { 'for': 'python' }

Plug 'PProvost/vim-ps1'
Plug 'ekalinin/Dockerfile.vim'

Plug 'derekwyatt/vim-scala', { 'for': 'scala' }

Plug 'Rykka/riv.vim', { 'for': 'rst' }
Plug 'amix/vim-zenroom2', { 'for': [ 'markdown', 'rst', 'txt'] }
Plug 'lervag/vimtex', {'for': 'tex'}
" Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'hdima/python-syntax', { 'for': 'python'}

Plug 'lilydjwg/colorizer'
Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'javascript'] }
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
" Shougo [[[2
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neoyank.vim'
if s:is_win
  Plug 'Shougo/vimproc.vim'
else
  Plug 'Shougo/vimproc.vim', {'do' : 'make'}
endif
" junegunn [[[2
Plug 'junegunn/goyo.vim', { 'for': [ 'markdown', 'rst', 'text'] }
Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'junegunn/limelight.vim', { 'for': [ 'markdown', 'rst', 'text'] }
Plug 'junegunn/vim-easy-align',   { 'on': '<plug>(LiveEasyAlign)' }
Plug 'junegunn/vim-peekaboo'
" bennyyip [[[2
" https://github.com/universal-ctags/ctags
Plug 'bennyyip/tagbar', { 'on': 'TagbarToggle' }
Plug 'bennyyip/denite-github-stars'
" plug#end [[[2
call plug#end()
" Setting [[[1
" general settings [[[2
" init [[[3
language en_US.utf8
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

runtime macros/matchit.vim
" indent settings [[[3
set autoindent
set cinoptions    =>2,l1,p0,)50,*50,t0
" set expandtab
" set smarttab
" set softtabstop   =2
" set shiftwidth    =2
" set shiftround
" set tabstop       =2
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
set viminfo     ='100,n$v/files/info/viminfo
" apperance [[[2
" Plugin: itchyny/lightline.vim [[[3
" g:lightline[[[4
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
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
      \ 'separator':    { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }
function! LightlineModified() "[[[4
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! LightlineReadonly() "[[[4
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? "\ue0a2" : ''
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
      return branch !=# '' ? "\ue0a0 ".branch : ''
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
""hi EndOfBuffer guibg=#282828 guifg=#282828
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
" less style nohl [[[3
nmap <silent> <M-u> :nohls<CR>
" run external command [[[3
nmap <leader>; :AsyncRun<space>
nmap <leader>: :VimProcBang<space>
nmap <silent>  <leader>u; :Denite -no-statusline command_history<CR>
" edit [[[3
inoremap <silent><C-BS> <C-w>
inoremap {<CR>          {}<left><CR><ESC>O
inoremap (<CR>          ()<left><CR><ESC>O
" yank [[[3
inoremap <silent><C-v>      <C-r>+
xnoremap <silent><C-c>      "+y
nmap     Y                  y$
nmap     <silent><leader>uy :Denite -no-statusline neoyank<CR>
" reload vimrc [[[3
nnoremap <leader>fed <Esc>:e $MYVIMRC<CR>
nnoremap <leader>vr  :so $MYVIMRC<CR>
" keep selection when indent line in visual mode [[[3
xnoremap <  <gv
xnoremap >  >gv
" script helper [[[3
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)
" resolve vcs conflict (depends on tpope/vim-unimpaired) [[[3
map <leader>dg1 ]nd]n[ndd[ndd
map <leader>dg2 d]ndd]ndd
" count Chinese char [[[3
" nnoremap <leader>wc :%s/[\u4E00-\u9FCC]//gn<CR>
"count all char：g<C-g>
" quick edit macro  | ["register]<leader>m [[[3
nnoremap <leader>em  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
nnoremap Q @q
" quick substitute [[[2
vmap qs "zy:%s`<C-R>z``g<left><left>
" get output from python [[[2
imap <C-R>c <esc>:let @a=""<CR>:let @a = execute( "py3 print()")<left><left><left>
" Quit [[[3
nnoremap <silent><leader>Q :Sayonara!<CR>
nnoremap <silent><leader>q :Sayonara<CR>
inoremap <C-Q> <esc>:Sayonara<cr>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
let g:sayonara_confirm_quit = 0
" file [[[2
nnoremap <leader>fs :w<CR>
nnoremap <leader>fq :x<CR>
nnoremap <leader>fy :let @*=substitute(expand("%"), "/", "\\", "g")<CR>:echo "buffer path copied"<CR>
nnoremap <leader>fp :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>:echo "buffer folder path copied"<CR>
nmap     <silent>   <leader>fF :Denite -no-statusline file<CR>
nmap     <silent>   <leader>ff :Denite -no-statusline file_rec<CR>
nmap     <silent>   <leader>FF :call <SID>denite_file_with_path()<CR>
nmap     <silent>   <leader>Ff :call <SID>denite_file_rec_with_path()<CR>
nmap     <silent>   <leader>fr :Denite file_mru<CR>
nmap     cd         :lcd %:p:h<CR>:echo expand('%:p:h')<CR>
cmap     w!!        w !sudo tee % >/dev/null
" buffer [[[2
nnoremap <silent><leader><tab> :<C-u>b#<CR>
nmap     <silent><leader>ub    :Denite -no-statusline buffer<CR>
nnoremap gb                    :ls<cr>:e #
nmap <right> :next<CR>
nmap <left> :previous<CR>
" tab [[[2 noremap  <silent><C-tab> :tabprev<CR>
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
" fold [[[2
nnoremap <silent><space><space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
vnoremap <silent><space><space> zf
nmap z] zo]z
nmap z[ zo[z
"  Windows [[[3
nnoremap <silent><leader>ex :execute 'AsyncRun explorer' getcwd()<CR>
nnoremap <leader>ps         :!start powershell<CR>
" move [[[2
nnoremap <M-j> gj
nnoremap <M-k> gk
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <left>
inoremap <M-l> <Right>
" remap H and L
nnoremap H ^
nnoremap L g_
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
"au * ShowSpaces
au BufWritePre * TrimSpaces
au FileAppendPre * TrimSpaces
au FileWritePre * TrimSpaces
au FilterWritePre * TrimSpaces
" Plugin Config [[[1
" Plugin: Shougo/denite.nvim [[[2
let s:denite_options = {
      \ 'default' : {
      \ 'winheight' : 15,
      \ 'mode' : 'insert',
      \ 'quit' : 'true',
      \ 'highlight_matched_char' : 'MoreMsg',
      \ 'highlight_matched_range' : 'MoreMsg',
      \ 'direction': 'rightbelow',
      \ 'prompt' : '>',
      \ }}
function! s:profile(opts) abort
  for fname in keys(a:opts)
    for dopt in keys(a:opts[fname])
      call denite#custom#option(fname, dopt, a:opts[fname][dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)

"let g:denite_force_overwrite_statusline = 1
" Ripgrep for file_rec
call denite#custom#var('file_rec', 'command',
      \ ['rg', '--files', '.'])

" Ripgrep command on grep source
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
      \ ['--vimgrep', '--no-heading','-i'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

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
nmap <silent> <leader>ur :Denite -resume<CR>
nmap <silent> <leader>ug :Denite -no-statusline grep<CR>
nmap <silent> <leader>uw :DeniteCursorWord -no-statusline grep<CR><CR>
nmap <silent> <leader>uj :Denite -no-statusline line<CR>
nmap <silent> <leader>ut :Denite -no-statusline filetype<CR>
nmap <silent> <leader>og :Denite -no-statusline github_stars<CR>
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
" Plugin: junegunn/goyo.vim [[[2
nnoremap <silent> <leader>z :Goyo<cr>
"autocmd! User GoyoEnter Limelight
"autocmd! User GoyoLeave Limelight!
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
"Plugin: christoomey/vim-tmux-navigator [[[2

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
  autocmd FileType dirvish silent keeppatterns g@\v[/\\]\.[^\\/]+[\\/]?$@d

  autocmd FileType dirvish nmap <buffer> <c-o> -
  " double "space" to preview
  autocmd FileType dirvish nmap <silent><buffer> <space><space> p<C-w>p
augroup END
" Plugin: vimers/vim-youdao [[[2
nnoremap <leader>oy :Dic<CR>
" Plugin: roxma/vim-paste-easy [[[2
let g:paste_easy_message=0
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
" Plugin: marksbrowser [[[2
nmap <silent><leader>um :MarksBrowser<CR><esc>
" Plugin: w0rp/ale [[[2
let g:ale_tex_lacheck_executable="shutup" "shutup is a program that do nothing, mute lacheck
" Plugin: vim-easy-align [[[2
xmap <cr> <plug>(LiveEasyAlign)
" Plugin justinmk/vim-sneak [[[2
let g:sneak#label = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
" map T <Plug>Sneak_T
" Plugin Valloric/ListToggle [[[2
let g:lt_location_list_toggle_map = '<leader>ol'
let g:lt_quickfix_list_toggle_map = '<leader>l'
" Plugin vimwiki/vimwiki [[[2
let g:vimwiki_list = [{'template_deafult': 'default' }]

" ending [[[1
runtime local.vim
" vim:fdm=marker:fmr=[[[,]]]
