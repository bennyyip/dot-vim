Plugin 'k-takata/minpac', {'type': 'opt'}
" general [[[1
Plugin 'junegunn/gv.vim'
Plugin 'junegunn/vim-easy-align'

Plugin 'Shougo/neosnippet-snippets'
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/junkfile.vim'
Plugin 'honza/vim-snippets'

Plugin 'dyng/ctrlsf.vim'
Plugin 'romainl/vim-qf'
Plugin 'yegappan/greplace'

Plugin 'bennyyip/is.vim'
Plugin 'markonm/traces.vim'
Plugin 'haya14busa/vim-asterisk'
Plugin 'justinmk/vim-sneak'

Plugin 'hotoo/pangu.vim'

Plugin 'AndrewRadev/linediff.vim'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'airblade/vim-rooter'
Plugin 'mhinz/vim-sayonara'
Plugin 'nhooyr/neoman.vim'
Plugin 'tweekmonster/startuptime.vim'
Plugin 'vim-voom/VOoM'
Plugin 'simnalamburt/vim-mundo'

Plugin 'tommcdo/vim-exchange'
Plugin 'tommcdo/vim-fugitive-blame-ext'
Plugin 'tommcdo/vim-fubitive'

Plugin 'bennyyip/YankRing.vim'
Plugin 'machakann/vim-highlightedyank'

Plugin 'andymass/vim-matchup'

Plugin 'vimoutliner/vimoutliner'

Plugin 'justinmk/vim-gtfo'
Plugin 'bergercookie/vim-debugstring'

Plugin 'bootleq/vim-cycle'
" leaderf [[[2
if !(v:version < 704 || v:version == 704 && has("patch330") == 0)
  Plugin 'Yggdroot/LeaderF'
  Plugin 'Yggdroot/LeaderF-marks'
  Plugin 'bennyyip/LeaderF-github-stars'
  Plugin 'bennyyip/LeaderF-ghq'
endif
" vim 8 [[[2
Plugin 'maralla/completor.vim'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'w0rp/ale'
" *nix stuff [[[ 2
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'lilydjwg/fcitx.vim'
" look [[[2
Plugin 'itchyny/lightline.vim'
Plugin 'mhinz/vim-startify'
Plugin 'morhetz/gruvbox'
Plugin 'vim-scripts/lilypink'
Plugin 'hachy/eva01.vim'
Plugin 'luochen1990/rainbow'
Plugin 'itchyny/vim-cursorword'
" tpope [[[2
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-apathy'
Plugin 'tpope/vim-capslock'
Plugin 'tpope/vim-characterize'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-jdaddy'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-vinegar'
" language [[[1
Plugin 'PProvost/vim-ps1', {'type': 'opt', 'for': ['ps1', 'ps1xml'] }
Plugin 'Shiracamus/vim-syntax-x86-objdump-d'
Plugin 'cespare/vim-toml', {'type': 'opt', 'for': 'toml' }
Plugin 'derekwyatt/vim-scala', {'type': 'opt', 'for': 'scala' }
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'octol/vim-cpp-enhanced-highlight', {'type': 'opt', 'for': 'cpp' }
Plugin 'racer-rust/vim-racer', {'type': 'opt', 'for': 'rust' }
Plugin 'tikhomirov/vim-glsl', {'type': 'opt', 'for': 'glsl' }
Plugin 'rust-lang/rust.vim', {'type': 'opt', 'for': 'rust' }
Plugin 'Firef0x/PKGBUILD.vim', {'type': 'opt', 'for': ['PKGBUILD', 'PKGINFO'] }
Plugin 'fatih/vim-go', {'type': 'opt', 'do': ':GoUpdateBinaries', 'for': 'go'}
" python [[[2
Plugin 'davidhalter/jedi-vim', {'type': 'opt', 'for': 'python' }
Plugin 'vim-python/python-syntax', {'type': 'opt', 'for': 'python'}
" typescript [[[2
Plugin 'leafgarland/typescript-vim', {'type': 'opt', 'for': 'typescript'}
" markup [[[2
Plugin 'Rykka/riv.vim', {'type': 'opt', 'for': 'rst' }
Plugin 'iamcco/markdown-preview.vim', {'type': 'opt', 'for': 'markdown', 'on': 'MarkdownPreview' }
Plugin 'lervag/vimtex', {'type': 'opt','for': 'tex'}
" web [[[2
Plugin 'lilydjwg/colorizer'
Plugin 'mattn/emmet-vim', {'type': 'opt', 'for': ['xml', 'html', 'css', 'javascript'] }
Plugin 'othree/html5.vim', {'type': 'opt','for': 'html'}
" vim:fdm=marker:fmr=[[[,]]]:ft=vim
