Plug 'k-takata/minpac', {'type': 'opt'}
" general [[[1
Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'junegunn/vim-easy-align'

Plug 'Shougo/neosnippet-snippets', { 'type': 'opt' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/junkfile.vim'
Plug 'honza/vim-snippets', { 'type': 'opt' }

Plug 'dyng/ctrlsf.vim'
Plug 'romainl/vim-qf'
Plug 'yegappan/greplace'

Plug 'bennyyip/is.vim'
Plug 'markonm/traces.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'justinmk/vim-sneak'

Plug 'hotoo/pangu.vim', { 'on': 'Pangu' }

Plug 'AndrewRadev/linediff.vim', { 'on': 'Linediff' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'airblade/vim-rooter', { 'on': 'Rooter' }
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
Plug 'nhooyr/neoman.vim'
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
Plug 'vim-voom/VOoM', { 'on': 'Voom' }
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }

Plug 'tommcdo/vim-exchange'
Plug 'tommcdo/vim-fugitive-blame-ext'
Plug 'tommcdo/vim-fubitive'

Plug 'bennyyip/YankRing.vim'
Plug 'machakann/vim-highlightedyank'

Plug 'andymass/vim-matchup'

Plug 'vimoutliner/vimoutliner'

Plug 'justinmk/vim-gtfo'
Plug 'bergercookie/vim-debugstring'

Plug 'bootleq/vim-cycle'
" leaderf [[[2
if !(v:version < 704 || v:version == 704 && has("patch330") == 0)
  Plug 'Yggdroot/LeaderF', {'do': {-> system('./install.sh')}}
  Plug 'Yggdroot/LeaderF-marks'
  Plug 'bennyyip/LeaderF-github-stars'
  Plug 'bennyyip/LeaderF-ghq'
endif
" vim 8 [[[2
Plug 'maralla/completor.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/asyncrun.vim', { 'on': 'AsyncRun' }
Plug 'w0rp/ale'
" *nix stuff [[[ 2
Plug 'christoomey/vim-tmux-navigator'
Plug 'lilydjwg/fcitx.vim'
" look [[[2
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'vim-scripts/lilypink', { 'type': 'opt' }
Plug 'hachy/eva01.vim', { 'type': 'opt' }
Plug 'luochen1990/rainbow'
Plug 'itchyny/vim-cursorword'
" tpope [[[2
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-capslock'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
" language [[[1
Plug 'PProvost/vim-ps1', { 'for': ['ps1', 'ps1xml'] }
Plug 'Shiracamus/vim-syntax-x86-objdump-d'
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
Plug 'ekalinin/Dockerfile.vim'
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'Firef0x/PKGBUILD.vim', { 'for': ['PKGBUILD', 'PKGINFO'] }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
" python [[[2
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'vim-python/python-syntax', { 'for': 'python'}
" typescript [[[2
Plug 'leafgarland/typescript-vim', { 'for': 'typescript'}
" markup [[[2
Plug 'Rykka/riv.vim', { 'for': 'rst' }
Plug 'iamcco/markdown-preview.vim', { 'for': 'markdown' }
Plug 'lervag/vimtex', {'for': 'tex' }
" web [[[2
Plug 'lilydjwg/colorizer'
Plug 'mattn/emmet-vim', { 'for': ['xml', 'html', 'css', 'javascript'] }
Plug 'othree/html5.vim', {'for': 'html' }
" vim:fdm=marker:fmr=[[[,]]]:ft=vim
