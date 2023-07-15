vim9script
const minpac_dir = $v .. '/pack/minpac/opt/minpac'
if !isdirectory(minpac_dir)
  silent! execute printf('!git clone https://github.com/k-takata/minpac.git %s', minpac_dir)
endif

g:plugpac_rc_path = $v .. '/rc'
g:plugpac_default_type = 'delay'
plugpac#Begin()
Pack 'k-takata/minpac', {'type': 'opt'}

Pack 'tpope/vim-sensible', { 'type': 'start' }
Pack 'lifepillar/vim-gruvbox8', { 'type': 'start' }
Pack 'tpope/vim-surround'
Pack 'tpope/vim-unimpaired'

if !g:minimal_plugins
  # general [[[2
  Pack 'junegunn/gv.vim', { 'on': 'GV' }
  Pack 'junegunn/vim-easy-align'
  Pack 'junegunn/fzf'
  Pack 'junegunn/fzf.vim'

  Pack 'dyng/ctrlsf.vim'
  Pack 'romainl/vim-qf'
  Pack 'yegappan/greplace'

  Pack 'bennyyip/is.vim'
  Pack 'markonm/traces.vim'
  Pack 'haya14busa/vim-asterisk'

  Pack 'cocopon/vaffle.vim'

  Pack 'justinmk/vim-sneak'

  Pack 'hotoo/pangu.vim'

  Pack 'AndrewRadev/linediff.vim', { 'on': 'Linediff' }
  Pack 'AndrewRadev/splitjoin.vim'
  Pack 'AndrewRadev/sideways.vim', { 'on': ['SidewaysLeft', 'SidewaysRight'] }
  Pack 'airblade/vim-rooter', { 'on': 'Rooter' }
  Pack 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
  Pack 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
  Pack 'vim-voom/VOoM', { 'on': 'Voom' }
  Pack 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }

  Pack 'tommcdo/vim-exchange'
  Pack 'tommcdo/vim-fugitive-blame-ext'
  Pack 'tommcdo/vim-fubitive', {'type': 'start'}

  Pack 'svermeulen/vim-yoink'
  Pack 'machakann/vim-highlightedyank'

  Pack 'andymass/vim-matchup'

  Pack 'vimoutliner/vimoutliner'

  Pack 'justinmk/vim-gtfo'
  Pack 'bergercookie/vim-debugstring'

  Pack 'bootleq/vim-cycle'

  Pack 'voldikss/vim-searchme'
  Pack 'voldikss/vim-translate-me'

  Pack 'wellle/targets.vim'
  Pack 'michaeljsmith/vim-indent-object'

  Pack 'tomtom/tcomment_vim'

  # leaderf [[[3
  Pack 'Yggdroot/LeaderF', { 'do': "packadd LeaderF \| LeaderfInstallCExtension" }

  # coc [[[3
  Pack 'neoclide/coc.nvim', { 'branch': 'release', 'type': 'start' }

  # vim 8 [[[3
  Pack 'skywind3000/asyncrun.vim'
  Pack 'dense-analysis/ale', {'type': 'delay'}
  # *nix stuff [[[3
  Pack 'christoomey/vim-tmux-navigator'
  Pack 'lilydjwg/fcitx.vim'
  # look [[[3
  Pack 'itchyny/lightline.vim'
  Pack 'mhinz/vim-startify', { 'type': 'start' }
  Pack 'lifepillar/vim-gruvbox8', { 'type': 'start' }
  Pack 'luochen1990/rainbow', { 'type': 'start' }
  Pack 'itchyny/vim-cursorword'
  Pack 'bennyyip/vim-interestingwords'
  # tpope [[[3
  Pack 'tpope/vim-abolish'
  Pack 'tpope/vim-apathy'
  Pack 'tpope/vim-capslock'
  Pack 'tpope/vim-characterize'
  Pack 'tpope/vim-eunuch'
  Pack 'tpope/vim-fugitive', { 'type': 'start' }
  Pack 'tpope/vim-jdaddy'
  Pack 'tpope/vim-repeat', { 'type': 'start' }
  Pack 'tpope/vim-rhubarb'
  Pack 'tpope/vim-rsi'
  # language [[[2
  Pack 'PProvost/vim-ps1', { 'for': ['ps1', 'ps1xml'] }
  Pack 'Shiracamus/vim-syntax-x86-objdump-d', { 'type': 'start' }
  Pack 'cespare/vim-toml', { 'for': 'toml' }
  Pack 'derekwyatt/vim-scala', { 'for': 'scala' }
  Pack 'ekalinin/Dockerfile.vim', { 'for': ['yaml.docker-compose', 'Dockerfile'] }
  Pack 'chr4/nginx.vim', { 'type': 'opt' }
  Pack 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
  Pack 'tikhomirov/vim-glsl', { 'for': 'glsl' }
  Pack 'Firef0x/PKGBUILD.vim', { 'for': ['PKGBUILD', 'PKGINFO'] }
  Pack 'chrisbra/csv.vim', { 'type': 'opt' }
  # python [[[3
  Pack 'vim-python/python-syntax', { 'for': 'python'}
  # typescript [[[3
  Pack 'leafgarland/typescript-vim', { 'for': 'typescript'}
  Pack 'peitalin/vim-jsx-typescript'
  # markup [[[3
  Pack 'Rykka/riv.vim', { 'for': 'rst' }
  Pack 'iamcco/markdown-preview.vim', { 'for': 'markdown' }
  # Pack 'lervag/vimtex', {'for': 'tex' }
  # web [[[3
  Pack 'lilydjwg/colorizer'
  Pack 'mattn/emmet-vim', { 'for': ['xml', 'html', 'css', 'javascript', 'typescript', 'typescript.tsx'] }
  Pack 'othree/html5.vim', {'for': 'html' }
endif
plugpac#End()


#  vim:fdm=marker:fmr=[[[,]]]:ft=vim
