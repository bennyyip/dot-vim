let g:is_ssh = ($SSH_CONNECTION != "")
let s:is_win = has('win32')
let s:is_tty = !match(&term, 'linux') || !match(&term, 'win32')
let s:is_gvim = has('gui_running')
let $v = $HOME.(s:is_win ? '\vimfiles' : '/.vim')
" Plugins [[[1
call plugpac#begin()
Pack 'k-takata/minpac', {'type': 'opt'}
" general [[[2
Pack 'junegunn/gv.vim', { 'on': 'GV' }
Pack 'junegunn/vim-easy-align'

Pack 'Shougo/neosnippet-snippets', { 'type': 'opt' }
Pack 'Shougo/neosnippet.vim'
Pack 'Shougo/junkfile.vim'
Pack 'honza/vim-snippets', { 'type': 'opt' }

Pack 'dyng/ctrlsf.vim'
Pack 'romainl/vim-qf'
Pack 'yegappan/greplace'

Pack 'bennyyip/is.vim'
Pack 'markonm/traces.vim'
Pack 'haya14busa/vim-asterisk'
Pack 'justinmk/vim-sneak'

Pack 'hotoo/pangu.vim', { 'on': 'Pangu' }

Pack 'AndrewRadev/linediff.vim', { 'on': 'Linediff' }
Pack 'AndrewRadev/splitjoin.vim'
Pack 'airblade/vim-rooter', { 'on': 'Rooter' }
Pack 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
Pack 'nhooyr/neoman.vim'
Pack 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
Pack 'vim-voom/VOoM', { 'on': 'Voom' }
Pack 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }

Pack 'tommcdo/vim-exchange'
Pack 'tommcdo/vim-fugitive-blame-ext'
Pack 'tommcdo/vim-fubitive'

Pack 'bennyyip/YankRing.vim'
Pack 'machakann/vim-highlightedyank'

Pack 'andymass/vim-matchup'

Pack 'vimoutliner/vimoutliner'

Pack 'justinmk/vim-gtfo'
Pack 'bergercookie/vim-debugstring'

Pack 'bootleq/vim-cycle'

Pack 'janko-m/vim-test'

Pack 'voldikss/vim-searchme'

" leaderf [[[3
if !(v:version < 704 || v:version == 704 && has("patch330") == 0)
  Pack 'Yggdroot/LeaderF', {'do': {-> system('./install.sh')}}
  Pack 'Yggdroot/LeaderF-marks'
  Pack 'bennyyip/LeaderF-github-stars'
  Pack 'bennyyip/LeaderF-ghq'
endif
" vim 8 [[[3
Pack 'maralla/completor.vim'
Pack 'ludovicchabant/vim-gutentags'
Pack 'skywind3000/asyncrun.vim'
Pack 'w0rp/ale'
" *nix stuff [[[3
Pack 'christoomey/vim-tmux-navigator'
Pack 'lilydjwg/fcitx.vim'
" look [[[3
Pack 'itchyny/lightline.vim'
Pack 'mhinz/vim-startify'
Pack 'morhetz/gruvbox', { 'type': 'opt' }
Pack 'lifepiller/vim-gruvbox8'
Pack 'vim-scripts/lilypink', { 'type': 'opt' }
Pack 'hachy/eva01.vim', { 'type': 'opt' }
Pack 'luochen1990/rainbow'
Pack 'itchyny/vim-cursorword'
" tpope [[[3
Pack 'tpope/vim-abolish'
Pack 'tpope/vim-apathy'
Pack 'tpope/vim-capslock'
Pack 'tpope/vim-characterize'
Pack 'tpope/vim-commentary'
Pack 'tpope/vim-endwise'
Pack 'tpope/vim-eunuch'
Pack 'tpope/vim-fugitive'
Pack 'tpope/vim-jdaddy'
Pack 'tpope/vim-repeat'
Pack 'tpope/vim-rhubarb'
Pack 'tpope/vim-rsi'
Pack 'tpope/vim-sensible'
Pack 'tpope/vim-surround'
Pack 'tpope/vim-unimpaired'
Pack 'tpope/vim-vinegar'
" language [[[2
Pack 'PProvost/vim-ps1', { 'for': ['ps1', 'ps1xml'] }
Pack 'Shiracamus/vim-syntax-x86-objdump-d'
Pack 'cespare/vim-toml', { 'for': 'toml' }
Pack 'derekwyatt/vim-scala', { 'for': 'scala' }
Pack 'ekalinin/Dockerfile.vim', { 'for': ['yaml.docker-compose', 'Dockerfile'] }
Pack 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Pack 'racer-rust/vim-racer', { 'for': 'rust' }
Pack 'tikhomirov/vim-glsl', { 'for': 'glsl' }
Pack 'rust-lang/rust.vim', { 'for': 'rust' }
Pack 'Firef0x/PKGBUILD.vim', { 'for': ['PKGBUILD', 'PKGINFO'] }
Pack 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
" python [[[3
Pack 'davidhalter/jedi-vim', { 'for': 'python' }
Pack 'vim-python/python-syntax', { 'for': 'python'}
" typescript [[[3
Pack 'leafgarland/typescript-vim', { 'for': 'typescript'}
" markup [[[3
Pack 'Rykka/riv.vim', { 'for': 'rst' }
Pack 'iamcco/markdown-preview.vim', { 'for': 'markdown' }
Pack 'lervag/vimtex', {'for': 'tex' }
" web [[[3
Pack 'lilydjwg/colorizer'
Pack 'mattn/emmet-vim', { 'for': ['xml', 'html', 'css', 'javascript'] }
Pack 'othree/html5.vim', {'for': 'html' }
call plugpac#end()
" Setting [[[1
" general settings [[[2
" clear augroup on reload [[[3
if exists('#vimrc')
  augroup vimrc
    autocmd!
  augroup END
  augroup! vimrc
endif
" init [[[3
let g:mapleader = "\<Space>"
let g:localleader = "\\"
let g:vimsyn_folding = 'f'
let g:is_bash = 1
let g:lisp_rainbow = 1

let g:markdown_fenced_languages = ['vim']

let g:loaded_2html_plugin = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logipat = 1
" let g:loaded_matchparen = 1
let g:loaded_rrhelper = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_tarPlugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zipPlugin = 1
" indent settings [[[3
set autoindent
set cinoptions=>2,l1,p0,)50,*50,t0
" Don't mess with 'tabstop', with 'expandtab' it isn't used.
" Instead set softtabstop=-1, then 'shiftwidth' is used.
set smarttab expandtab shiftwidth=4 softtabstop=-1
" display settings [[[3
set display=lastline
set laststatus=2
set list
set modeline
set modelines=1
set nostartofline
set numberwidth=1
set shortmess=aoOTI
set showcmd
set showmatch
set matchtime=0
set showmode

set fileencoding=utf-8
set fileencodings=utf-8,gbk,gb18030,gb2312,cp936,usc-bom,euc-jp
set encoding=utf-8
scriptencoding utf-8


if !s:is_tty
  if s:is_win
    set renderoptions=type:directx
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
endif " s:is_tty
" turn off bell [[[3
set noerrorbells
set novisualbell
set t_vb=
if exists('&belloff')
  set belloff=all
endif
" better navigation [[[3
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
set sidescroll=5
set number            " line number
set relativenumber    " relative line number
if has('mouse')
  set mouse=
  set mousehide
endif
" wild stuff [[[3
set suffixes     +=.a,.1,.class
set wildignore   +=*.o,*.so,*.zip,*.png
set wildmenu
"set wildmode=list:longest,full
set wildoptions=tagfile
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
set formatoptions+=m    "允许对multi_byte字符换行（否则默认只能空格或者英文标点，详见set breakat=）
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
set synmaxcol=99999          " Only highlight the first 500 columns.
set history=1000
set backspace=indent,eol,start
set hidden
set nrformats-=octal
set splitbelow
set splitright
set titlestring=VIM:\ %f
set switchbuf=useopen,usetab
set ttyfast
set lazyredraw
" set timeoutlen=500
" set ttimeoutlen=50
set noshowmode " Hide the mode text (e.g. -- INSERT --)

" diffopt
if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
endif

"LF
set fileformat=unix
set fileformats=unix,dos

" use old regex engine for better performance
set regexpengine=1

" this makes sure that shell scripts are highlighted
" as bash scripts and not sh scripts
let g:is_posix = 1

set cmdheight=1
set langmenu=en_US
" backup/swap/info/undo settings [[[3
set backup
set backupskip=
set updatecount=100
set undofile
set backupdir=$v/files/backup/
set backupext=-vimbackup
set directory=$v/files/swap/
set undodir=$v/files/undo/
set viminfo='100,n$v/files/info/viminfo
" apperance [[[2
" colorscheme [[[3
set background=dark
colorscheme gruvbox8
let g:gruvbox_plugin_hi_groups = 1
let g:gruvbox_filetype_hi_groups = 1
if s:is_gvim
  let g:gruvbox_italic = 1
  let g:gruvbox_italicize_strings = 1
else
  let g:gruvbox_italic = 0
  let g:gruvbox_italicize_strings = 0
endif
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
      \ 'inactive': {
      \ 'left': [ [ 'filename' ] ],
      \ 'right': [ [ 'lineinfo' ],
      \            [ 'percent' ] ],
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
      \   'asyncrun':     'LightlineAsyncrun',
      \ },
      \ }
if !s:is_tty
  if s:colorscheme == 'gruvbox'
    let g:lightline.colorscheme = 'gruvbox'
  elseif s:colorscheme == 'gruvbox8'
    let g:lightline.colorscheme = 'gruvbox8'
  else
    let g:lightline.colorscheme = 'one'
  endif
  let g:lightline.separator = { 'left': "\ue0b0", 'right': "\ue0b2" }
  let g:lightline.subseparator = { 'left': "\ue0b1", 'right': "\ue0b3" }
endif

function LightlineAsyncrun()
  return get(g:, 'asyncrun_status', '')
endfunction

function! LightlineModified() "[[[4
  return &filetype =~# 'help\|vimfiler\|Mundo\|qf' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! LightlineReadonly() "[[[4
  return &filetype !~? 'help\|vimfiler\|Mundo\|qf' && &readonly ? (s:is_tty ? 'RO' : "\ue0a2") : ''
endfunction
function! LightlineFilename() "[[[4
  if &filetype ==# 'qf'
    let wininfo = filter(getwininfo(), {i,v -> v.winnr == winnr()})[0]
    if wininfo.loclist
      return "[Location List]"
    else
      return "[Quickfix List]"
    endif
  endif

  let l:fname = expand('%:~')
  return l:fname ==# '__Tagbar__' ? g:lightline.l:fname :
        \ l:fname =~# '__Mundo\|NERD_tree' ? '' :
        \ &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'denite' ? denite#get_status_sources() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ ('' !=# LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' !=# l:fname ? l:fname : '[No Name]') .
        \ ('' !=# LightlineModified() ? ' ' . LightlineModified() : '')
endfunction
function! LightlineFugitive() "[[[4
  try
    if expand('%:t') !~? 'Tagbar\|Mundo\|NERD' && &filetype !~? 'vimfiler' && exists('*fugitive#head')
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
" other [[[3
" terminal true color
if !g:is_ssh && has("termguicolors")
  " fix bug for vim
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum

  " enable true color
  set termguicolors
endif
if s:is_win
  let &pythonthreedll = 'C:\Program Files\Python37\python37.dll'
  silent! python3 pass
  let g:netrw_cygwin = 0
  let g:netrw_silent = 1

  if s:is_gvim
    "https://github.com/derekmcloughlin/gvimfullscreen_win32
    augroup vimrc
      autocmd GUIEnter * call libcallnr("gvimfullscreen_64.dll", "ToggleFullScreen", 0)
      autocmd GUIEnter * nmap <leader>tf :call libcallnr("gvimfullscreen_64.dll", "ToggleFullScreen", 0)<CR>
    augroup END
    set guioptions-=egmrLtT
    set guifont=Sarasa\ Term\ CL:h14
  endif
else
  set guioptions-=aegimrLtT
  set guifont=Monospace\ 14
endif
" Key Mapping [[[1
" misc [[[2
nmap     t= mxHmygg=G`yzt`x
nmap     tj Jx

nnoremap <localleader>j :set ft=javascript<CR>
nnoremap <localleader>h :set ft=html<CR>
" toogle line number and relative line number
function! s:number_options() abort
  return &number && &relativenumber ? 'nonumber norelativenumber' : 'number relativenumber'
endfunction
nnoremap yoN :set <C-R>=<SID>number_options()<CR><CR>
nnoremap [oN :set number relativenumber<CR>
nnoremap ]oN :set nonumber norelativenumber<CR>

" fold [[[3
nmap z] zo]z
nmap z[ zo[z
" correct spell [[[3
cab Q q
cab Qa qa
cab W w
cab Wq wq
cab Wa wa
cab X x
" syntax [[[3
nnoremap <leader>si  :echo ben#syninfo()<cr>
nnoremap <leader>ss  :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<cr>
" diff [[[3
nnoremap <silent><leader>di :windo diffthis<CR>
nnoremap <silent><leader>du :windo diffupdate<CR>
nnoremap <silent><leader>do :windo diffoff<CR>
" linewise partial staging in visual-mode.
xnoremap <c-p> :diffput<cr>
xnoremap <c-o> :diffget<cr>
" toggle iwhite
nnoremap yo<space> :set <C-R>=(&diffopt =~# 'iwhite') ? 'diffopt-=iwhite' : 'diffopt+=iwhite'<CR><CR>
" quickfix and loclist [[[3
nnoremap <silent>  <q :call quickfixed#older()<CR>
nnoremap <silent>  >q :call quickfixed#newer()<CR>
" nohl [[[3
" Use <backspace> to:
"   - redraw
"   - clear 'hlsearch'
"   - update the current diff (if any)
" Use {count}<backspace> to:
"   - reload (:edit) the current buffer
nnoremap <silent><expr> <backspace> (v:count ? ':<C-U>:call ben#save_change_marks()\|edit\|call ben#restore_change_marks()<CR>' : '')
      \ . ':nohlsearch'.(has('diff')?'\|diffupdate':'')
      \ . '<CR><C-L>'
nnoremap z. :call ben#save_change_marks()<Bar>w<Bar>call ben#restore_change_marks()<cr>z.
" window [[[2
" quick <C-w>
nnoremap ' <C-w>
if s:is_win || s:is_gvim
  let g:tmux_navigator_no_mappings=1
  nnoremap <silent><C-h> <C-w>h
  nnoremap <silent><C-j> <C-w>j
  nnoremap <silent><C-k> <C-w>k
  nnoremap <silent><C-l> <C-w>l
endif
" edit [[[2
inoremap (<CR> (<CR>)<Esc>O
inoremap {<CR> {<CR>}<Esc>O
inoremap {; {<CR>};<Esc>O
inoremap {, {<CR>},<Esc>O
inoremap [<CR> [<CR>]<Esc>O
inoremap [; [<CR>];<Esc>O
inoremap [, [<CR>],<Esc>O
inoremap <M-o> <C-O>o
inoremap <M-O> <C-O>O
" script helper
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)
" get output from python
imap <C-R>c <esc>:let @a=""<CR>:let @a = execute( "py3 print()")<left><left><left>
" time
inoremap <silent> <C-G><C-T> <C-R>=repeat(complete(col('.'),map(["%Y-%m-%d %H:%M:%S","%a, %d %b %Y %H:%M:%S %z","%Y %b %d","%d-%b-%y","%a %b %d %T %Z %Y"],'strftime(v:val)')+[localtime()]),0)<CR>
" yank and paste [[[2
cnoremap <C-v>         <C-R>+
inoremap <silent><C-v> <C-O>:set paste<CR><C-R>+<C-O>:set nopaste<CR>
inoremap <silent><C-z> <ESC>u
xnoremap <silent>Y     "+y
xnoremap <silent><C-c> "+y
nnoremap Y   y$
xnoremap x  "_d
xnoremap P  "0p
nmap     tp "+P
" slect what I just pasted
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" copy entire file contents (to gui-clipboard if available)
nnoremap yY :let b:winview=winsaveview()<bar>exe 'keepjumps keepmarks norm ggVG'.(has('clipboard')?'"+y':'y')<bar>call winrestview(b:winview)<cr>
" vimrc
nnoremap <leader>fed :e $MYVIMRC<CR>
nnoremap <leader>fee :so $MYVIMRC<CR>
" run current line
nnoremap <silent> yr :exec getline('.') \| echo 'executed!'<CR>
" visual [[[2
" keep selection when indent line in visual mode
xnoremap <expr> > v:count ? ">" : ">gv"
xnoremap <expr> < v:count ? "<" : "<gv"
" niceblock
xnoremap <expr> I (mode()=~#'[vV]'?'<C-v>^o^I':'I')
xnoremap <expr> A (mode()=~#'[vV]'?'<C-v>0o$A':'A')

" quick edit macro  | ["register]<leader>m
nnoremap <leader>em  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
nnoremap Q @q
xnoremap Q :normal @q<CR>
" repeat last command for each line of a visual selection
xnoremap . :normal .<CR>
" search and substitute [[[2
" quick substitute
vnoremap qs "zy:%s`<C-R>z``g<left><left>
nnoremap qs :%s`<C-R><C-W>``g<left><left>
vnoremap qS "zy:%S`<C-R>z``g<left><left>
nnoremap qS :%S`<C-R><C-W>``g<left><left>
nnoremap & n:&&<CR>
xnoremap & n:&&<CR>
" mark position before search
nnoremap / ms/
map n  nzzzv
map N  Nzzzv
" file, buffer [[[2
nnoremap <leader>fs :w<CR>
nnoremap <leader>fy :let @+=expand("%")<CR>:echo "buffer filename copied"<CR>
nnoremap <leader>fp :let @+=expand("%:p")<CR>:echo "buffer path copied"<CR>
nnoremap cd :lcd %:p:h<bar>pwd<cr>
nnoremap cu :lcd ..<bar>pwd<cr>

nnoremap <silent><leader><tab> :<C-u>b!#<CR>
" tab [[[2
nmap     T :tabnew<cr>
noremap  <silent><C-tab> :tabprev<CR>
inoremap <silent><C-tab> <ESC>:tabprev<CR>
function! s:switch_tab(i)
  if tabpagenr() == a:i
    return ":tabprev\<CR>"
  else
    return ":tabn ".a:i."\<CR>"
  endif
endfunction
function! s:map_switch_tab()
  for l:i in range(1, 9)
    execute printf("nnoremap <silent><expr> <leader>%d <SID>switch_tab(%d)", l:i, l:i)
    if s:is_gvim
      execute printf("nnoremap <silent><expr> <M-%d> <SID>switch_tab(%d)", l:i, l:i)
    else
      " Use customized key code for alt mappings to avoid breaking macros like
      " `<ESC>j`, see:
      " https://github.com/bennyyip/dotfiles/blob/master/config/.config/alacritty/alacritty.yml
      " https://zhuanlan.zhihu.com/p/20902166
      execute printf("nnoremap <silent><expr> <ESC>]{0}%d~ <SID>switch_tab(%d)", l:i, l:i)
    endif
  endfor
endfunction
call s:map_switch_tab()
" move [[[2
nnoremap <Down> gj
nnoremap <Up> gk
inoremap <Down> <C-R>=pumvisible() ? "\<lt>Down>" : "\<lt>C-O>gj"<CR>
inoremap <Up>   <C-R>=pumvisible() ? "\<lt>Up>" : "\<lt>C-O>gk"<CR>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <left>
inoremap <M-l> <Right>
noremap H ^
noremap L $
" Command [[[1
" :Reverse [[[2
command! -bar -range=% Reverse <line1>,<line2>global/^/m<line1>-1<bar>nohl
" ChineseCount [[[2
function! ChineseCount() range
	let save = @z
	silent exec 'normal! gv"zy'
	let text = @z
	let @z = save
	silent exec 'normal! gv'
	let cc = 0
	for char in split(text, '\zs')
		if char2nr(char) >= 0x2000
			let cc += 1
		endif
	endfor
	echo "Count of Chinese charasters is:"
	echo cc
endfunc

vnoremap <F7> :call ChineseCount()<cr>

" :Shuffle | Shuffle selected lines [[[2
command! -range Shuffle <line1>,<line2>call ben#shuffle()
" :OpenUrl [[[2
command! -nargs=1 OpenURL :call ben#open_url(<q-args>)
nnoremap <silent> gx :call ben#open_url()<CR>
" :A [[[2
command! A call ben#a('e')
command! AV call ben#a('botright vertical split')
" :PX | chmod +x [[[2
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
command! -bar -count=0 RFC     :e http://www.rfc-editor.org/rfc/rfc<count>.txt|setl ro noma
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
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#disable_runtime_snippets = {
      \  '_' : 1,
      \ }
let g:neosnippet#snippets_directory = '$v/snippets'
" Plugin: is.vim [[[2
let g:is#do_default_mappings = 1
let g:is#auto_nohlsearch = 0
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
let s:ascii_art = [
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
      \ map(s:ascii_art + ben#quote(), '"   ".v:val')
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
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1
let g:startify_enable_special = 0
let g:startify_files_number = 7
let g:startify_session_dir = $v.'/files/session'
let g:startify_session_autoload = 0
let g:startify_session_persistence = 0
let g:startify_update_oldfiles = 1
let g:startify_use_env = 1
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
" Plugin: christoomey/vim-tmux-navigator [[[2
let g:tmux_navigator_save_on_switch = 2
" Plugin: tpope/vim-vinegar [[[2
" let g:loaded_netrw = 1
" let g:loaded_netrwPlugin = 1
augroup vimrc
  autocmd FileType netrw setl bufhidden=delete
augroup END
let g:netrw_banner = 0
let g:netrw_bufsettings = 'relativenumber'
let g:netrw_keepdir = 0
let g:netrw_liststyle = 1
let g:netrw_sort_options = 'i'
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_timefmt = '%H:%M %y-%m-%d'
let g:netrw_sizestyle = 'H'
" Plugin: luochen1990/rainbow [[[2
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
let g:completor_racer_binary = '/usr/bin/racer'
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
inoremap <C-space> <C-X><C-O>
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
      \   'tex': s:general_ale_fixer,
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
      \   'json': s:general_ale_fixer + [
      \       'jq',
      \   ],
      \   'go': s:general_ale_fixer + [
      \       'goimports',
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
" Plugin: justinmk/vim-sneak [[[2
let g:sneak#label = 1
" Plugin: Yggdroot/LeaderF [[[2
let g:Lf_DefaultExternalTool = 'rg'
let g:Lf_ShortcutF='<leader>ff'
let g:Lf_ShortcutB='gb'
let g:Lf_MruMaxFiles=500
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2"}
if s:colorscheme == 'gruvbox'
  let g:Lf_StlColorscheme = 'gruvbox'
elseif s:colorscheme == 'gruvbox8'
  let g:Lf_StlColorscheme = 'gruvbox8'
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
" Plugin: skywind3000/asyncrun.vim [[[2
if s:is_win
  let g:asyncrun_encs = 'gbk'
endif
let g:asyncrun_save = 1
" Plugin: airblade/vim-rooter [[[2
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_manual_only = 1
let g:rooter_use_lcd = 1
let g:rooter_patterns = ['Cargo.toml', 'mix.exs', 'Makefile', '.git/', '.svn/']
" Plugin: romainl/vim-qf [[[2
let g:qf_mapping_ack_style = 1
let g:qf_auto_open_quickfix = 0
let g:qf_auto_open_loclist = 0
let g:qf_auto_quit = 0
" Plugin: lilydjwg/colorizer [[[2
let g:colorizer_nomap = 1
let g:colorizer_startup = 0
" Plugin: AndrewRadev/linediff.vim [[[2
let g:linediff_buffer_type = 'scratch'
" Plugin: vim-scripts/YankRing.vim [[[2
let g:yankring_map_dot = 0
let g:yankring_min_element_length = 2
" Plugin: andymass/vim-matchup [[[2
let g:loaded_matchit = 1
let g:matchup_transmute_enabled = 0
let g:matchup_override_vimtex = 1
" Plugin: justinmk/vim-gtfo [[[2
let g:gtfo#terminals = { 'unix': 'alacritty --working-directory' }
" Plugin: bootleq/vim-cycle [[[2
let g:cycle_default_groups = [
      \ [['true', 'false']],
      \ [['yes', 'no']],
      \ [['and', 'or']],
      \ [['on', 'off']],
      \ [['>', '<']],
      \ [['==', '!=']],
      \ [['是', '否']],
      \ [['有', '无']],
      \ [["in", "out"]],
      \ [["min", "max"]],
      \ [["get", "post"]],
      \ [["to", "from"]],
      \ [["read", "write"]],
      \ [['with', 'without']],
      \ [["exclude", "include"]],
      \ [["asc", "desc"]],
      \ [["next", "prev"]],
      \ [["encode", "decode"]],
      \ [["left", "right"]],
      \ [["hide", "show"]],
      \ [['「:」', '『:』'], 'sub_pairs'],
      \ [['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      \ 'Friday', 'Saturday'], 'hard_case', {'name': 'Days'}],
      \ [["enable", "disable"]],
      \ [["add", "remove"]],
      \ [['up', 'down']],
      \ [['after', 'before']],
      \ ]
let g:cycle_no_mappings = 1
" Plugin: fatih/vim-go [[[2
let g:go_fmt_autosave = 0
let g:go_def_mapping_enabled=0
" Plugin: davidhalter/jedi-vim [[[2
let g:jedi#completions_enabled = 0
" Plugin: vim-python/python-syntax [[[2
let g:python_highlight_all = 1
" Plugin: fatih/vim-go [[[2
let g:go_bin_path = expand("~/go/bin/")
" Plugin: lervag/vimtex [[[2
let g:tex_conceal=0

" ending [[[1
if filereadable($HOME. '/local.vim')
  source $HOME/local.vim
endif
" vim:fdm=marker:fmr=[[[,]]]:ft=vim
