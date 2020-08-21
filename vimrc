let g:is_ssh = ($SSH_CONNECTION != "")
let s:is_win = has('win32')
let s:is_tty = !match(&term, 'linux') || !match(&term, 'win32')
let s:is_gvim = has('gui_running')
let s:is_nvim = has('nvim')
let $v = $HOME.(s:is_win ? '\vimfiles' : '/.vim')
let $VIMRC = $v . '/vimrc'
" Setting [[[1
" general settings [[[2
set nocompatible
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
set shortmess=aoOTIc
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
if has('patch-8.1.1564')
  set signcolumn=number
else
  set signcolumn=yes
endif
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
set completeopt-=preview
set completeopt+=longest,menuone,noselect
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
let &diffopt = "internal,filler,closeoff,hiddenoff,algorithm:patience"
nnoremap <silent> [w :let &diffopt = "internal,filler,closeoff,hiddenoff,algorithm:patience"<CR>:echo &diffopt<CR>
nnoremap <silent> ]w :let &diffopt = "internal,filler,closeoff,hiddenoff,algorithm:patience,iwhiteall,iblank"<CR>:echo &diffopt<CR>

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
" Disable backup because of coc.nvim #649
set nobackup
set nowritebackup
" set backup
" set backupskip=
" set backupext=-vimbackup

set updatecount=100
set undofile
if s:is_nvim
  set backupdir -=.
  set shada      ='100
else

  let $vimtmp = $HOME . '/.config/vimtmp/'
  for s:tmp in ['backup', 'swap', 'undo', 'info']
    call mkdir($vimtmp . s:tmp, 'p')
  endfor

  set backupdir=$vimtmp/backup/
  set directory=$vimtmp/swap/
  set undodir=$vimtmp/undo/
  set viminfo='100,n$vimtmp/info/viminfo
endif
" apperance [[[2
" colorscheme [[[3
set background=dark
colorscheme gruvbox8
let g:gruvbox_material_background = 'hard'
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
      \              [ 'cocstatus', 'asyncrun', 'fileformat', 'fileencoding', 'filetype'] ]
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
      \   'cocstatus':    'coc#status',
      \ },
      \ }

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

if !s:is_tty
  if s:colorscheme == 'gruvbox'
    let g:lightline.colorscheme = 'gruvbox'
  elseif s:colorscheme == 'gruvbox8'
    let g:lightline.colorscheme = 'gruvbox8'
  elseif s:colorscheme == 'gruvbox-material'
    let g:lightline.colorscheme = 'gruvbox_material'
  else
    let g:lightline.colorscheme = 'one'
  endif
  " let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
  " let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
  " let g:lightline.tabline_separator = { 'left': "\ue0b8", 'right': "\ue0be" }
  " let g:lightline.tabline_subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
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
  set iminsert=2
  let &pythonthreedll = expand('$HOME\AppData\Local\Programs\Python\Python37\python37.dll')
  silent! python3 pass
  let g:netrw_cygwin = 0
  let g:netrw_silent = 1

  if s:is_gvim
    "https://github.com/derekmcloughlin/gvimfullscreen_win32
    augroup vimrc
      autocmd GUIEnter *  simalt ~x
    augroup END
    set guioptions-=egmrLtT
    set guifont=Sarasa\ Term\ CL:h14
  endif
else
  set guioptions-=aegimrLtT
  set guifont=Monospace\ 16
endif
" Plugins [[[1
let s:minpac_dir = $v . '/pack/minpac/opt/minpac'
if !isdirectory(s:minpac_dir)
  silent! execute printf('!git clone https://github.com/k-takata/minpac.git %s', s:minpac_dir)
end

let g:plugpac_cfg_path = $v . '/rc'
call plugpac#begin()
Pack 'k-takata/minpac', {'type': 'opt'}
" general [[[2
Pack 'junegunn/gv.vim', { 'on': 'GV' }
Pack 'junegunn/vim-easy-align', { 'type': 'lazyall' }

Pack 'Shougo/junkfile.vim', { 'type': 'lazy' }

Pack 'dyng/ctrlsf.vim', { 'type': 'lazyall' }
Pack 'romainl/vim-qf', { 'type': 'lazy' }
Pack 'yegappan/greplace', { 'type': 'lazy' }

Pack 'bennyyip/is.vim', { 'type': 'lazyall' }
Pack 'markonm/traces.vim', { 'type': 'lazy' }
Pack 'haya14busa/vim-asterisk', { 'type': 'lazyall' }

Pack 'cocopon/vaffle.vim'

Pack 'justinmk/vim-sneak', { 'type': 'lazyall' }

Pack 'hotoo/pangu.vim', { 'type': 'lazy' }

Pack 'AndrewRadev/linediff.vim', { 'on': 'Linediff' }
Pack 'AndrewRadev/splitjoin.vim', { 'type': 'lazy' }
Pack 'AndrewRadev/sideways.vim', { 'on': ['SidewaysLeft', 'SidewaysRight'] }
Pack 'airblade/vim-rooter', { 'on': 'Rooter' }
Pack 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
Pack 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
Pack 'vim-voom/VOoM', { 'on': 'Voom' }
Pack 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }

Pack 'tommcdo/vim-exchange', { 'type': 'lazy' }
Pack 'tommcdo/vim-fugitive-blame-ext', { 'type': 'lazy' }
Pack 'tommcdo/vim-fubitive', { 'type': 'lazy' }

Pack 'svermeulen/vim-yoink', { 'type': 'lazyall' }
Pack 'machakann/vim-highlightedyank', { 'type': 'lazyall' }

Pack 'andymass/vim-matchup', { 'type': 'lazy' }

Pack 'vimoutliner/vimoutliner', { 'type': 'lazyall' }

Pack 'justinmk/vim-gtfo', { 'type': 'lazy' }
Pack 'bergercookie/vim-debugstring', { 'type': 'lazy' }

Pack 'bootleq/vim-cycle', { 'type': 'lazyall' }

Pack 'janko-m/vim-test', {'type': 'lazy'}

Pack 'voldikss/vim-searchme', { 'type': 'lazyall' }
Pack 'voldikss/vim-translate-me', { 'type': 'lazyall' }

Pack 'wellle/targets.vim', { 'type': 'lazy' }
Pack 'michaeljsmith/vim-indent-object', { 'type': 'lazy' }

Pack 'tomtom/tcomment_vim', {'type': 'lazy'}

" leaderf [[[3
if !(v:version < 704 || v:version == 704 && has("patch330") == 0)
  Pack 'Yggdroot/LeaderF', {'do': {-> system('./install.sh')}}
  Pack 'Yggdroot/LeaderF-marks', {'type': 'lazy'}
  Pack 'bennyyip/LeaderF-github-stars', {'type': 'lazy'}
  Pack 'bennyyip/LeaderF-ghq', {'type': 'lazy'}
endif

" coc [[[3
Pack 'davidhalter/jedi-vim', { 'type': 'opt' }
Pack 'neoclide/coc.nvim', { 'branch': 'release' }
" if executable('node')
"   packadd! coc.nvim
" else
"   packadd! jedi-vim
" endif

" vim 8 [[[3
Pack 'skywind3000/asyncrun.vim', { 'type': 'lazyall' }
Pack 'w0rp/ale', {'type': 'lazyall'}
" *nix stuff [[[3
Pack 'christoomey/vim-tmux-navigator', { 'type': 'lazyall' }
Pack 'lilydjwg/fcitx.vim', { 'type': 'lazy' }
" look [[[3
Pack 'itchyny/lightline.vim', { 'type': 'lazyall' }
Pack 'mhinz/vim-startify'
Pack 'sainnhe/gruvbox-material', { 'type': 'opt' }
Pack 'morhetz/gruvbox', { 'type': 'opt' }
Pack 'lifepillar/vim-gruvbox8'
Pack 'vim-scripts/lilypink', { 'type': 'opt' }
Pack 'hachy/eva01.vim', { 'type': 'opt' }
Pack 'luochen1990/rainbow', { 'type': 'lazyall' }
Pack 'itchyny/vim-cursorword', { 'type': 'lazy' }
Pack 'bennyyip/vim-interestingwords', { 'type': 'lazy' }
" tpope [[[3
Pack 'tpope/vim-abolish', { 'type': 'lazyall' }
Pack 'tpope/vim-apathy', { 'type': 'lazy' }
Pack 'tpope/vim-capslock', { 'type': 'lazy' }
Pack 'tpope/vim-characterize', { 'type': 'lazy' }
Pack 'tpope/vim-eunuch', { 'type': 'lazy' }
Pack 'tpope/vim-fugitive'
Pack 'tpope/vim-jdaddy', { 'type': 'lazy' }
Pack 'tpope/vim-repeat'
Pack 'tpope/vim-rhubarb', { 'type': 'lazy' }
Pack 'tpope/vim-rsi', { 'type': 'lazy' }
Pack 'tpope/vim-sensible'
Pack 'tpope/vim-surround', { 'type': 'lazy' }
Pack 'tpope/vim-unimpaired', { 'type': 'lazy' }
" language [[[2
Pack 'fatih/vim-go', { 'type': 'lazy' }
Pack 'PProvost/vim-ps1', { 'for': ['ps1', 'ps1xml'] }
Pack 'Shiracamus/vim-syntax-x86-objdump-d'
Pack 'cespare/vim-toml', { 'for': 'toml' }
Pack 'derekwyatt/vim-scala', { 'for': 'scala' }
Pack 'ekalinin/Dockerfile.vim', { 'for': ['yaml.docker-compose', 'Dockerfile'] }
Pack 'chr4/nginx.vim', { 'type': 'opt' }
Pack 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Pack 'racer-rust/vim-racer', { 'for': 'rust' }
Pack 'tikhomirov/vim-glsl', { 'for': 'glsl' }
" Pack 'rust-lang/rust.vim', { 'type': 'opt', 'for': 'rust' }
Pack 'rust-lang/rust.vim', { 'type': 'lazy' }
Pack 'Firef0x/PKGBUILD.vim', { 'for': ['PKGBUILD', 'PKGINFO'] }
Pack 'chrisbra/csv.vim', { 'type': 'opt' }
" python [[[3
Pack 'vim-python/python-syntax', { 'for': 'python'}
" typescript [[[3
Pack 'leafgarland/typescript-vim', { 'for': 'typescript'}
Pack 'peitalin/vim-jsx-typescript', { 'type': 'lazy' }
" markup [[[3
Pack 'Rykka/riv.vim', { 'for': 'rst' }
Pack 'iamcco/markdown-preview.vim', { 'for': 'markdown' }
Pack 'lervag/vimtex', {'for': 'tex' }
" web [[[3
Pack 'lilydjwg/colorizer', { 'type': 'lazy' }
Pack 'mattn/emmet-vim', { 'for': ['xml', 'html', 'css', 'javascript', 'typescript', 'typescript.tsx'] }
Pack 'othree/html5.vim', {'for': 'html' }
call plugpac#end()
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
" nnoremap <leader>si  :echo ben#syninfo()<cr>
" nnoremap <leader>ss  :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<cr>
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
" select what I just pasted
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" copy entire file contents (to gui-clipboard if available)
nnoremap yY :let b:winview=winsaveview()<bar>exe 'keepjumps keepmarks norm ggVG'.(has('clipboard')?'"+y':'y')<bar>call winrestview(b:winview)<cr>
" vimrc
nnoremap <leader>fed :e $VIMRC<CR>
nnoremap <leader>fee :so $VIMRC<CR>
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
" file, buffer [[[2
nnoremap <leader>fs :w<CR>
nnoremap <leader>fy :let @+=expand("%")<CR>:echo "buffer filename copied"<CR>
nnoremap <leader>fp :let @+=expand("%:p")<CR>:echo "buffer path copied"<CR>
nnoremap cd :lcd %:p:h<bar>pwd<cr>
nnoremap cu :lcd ..<bar>pwd<cr>

nnoremap <silent><leader><tab> :<C-u>b!#<CR>
" tab [[[2
nmap     T :tabnew<cr>
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>
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
nnoremap <silent> gX :call ben#open_url()<CR>
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
command! -bar -count=0 RFC     :e /usr/share/doc/rfc/txt/rfc<count>.txt|setl ro noma
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
" Plugin: Yggdroot/LeaderF [[[2
let g:Lf_PopupColorscheme = 'gruvbox_material'
if s:colorscheme == 'gruvbox'
  let g:Lf_StlColorscheme = 'gruvbox'
elseif s:colorscheme == 'gruvbox8'
  let g:Lf_StlColorscheme = 'gruvbox8'
elseif s:colorscheme == 'gruvbox-material'
  let g:Lf_StlColorscheme = 'gruvbox_material'
else
  let g:Lf_StlColorscheme = 'one'
endif
" Plugin: skywind3000/asyncrun.vim [[[2
if s:is_win
  let g:asyncrun_encs = 'gbk'
endif
" ending [[[1
if filereadable($HOME. '/local.vim')
  source $HOME/local.vim
endif

" vim:fdm=marker:fmr=[[[,]]]:ft=vim
