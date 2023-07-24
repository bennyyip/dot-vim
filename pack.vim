vim9script

import autoload "./autoload/utils.vim" as Utils

const minpac_dir = $v .. '/pack/minpac/opt/minpac'
if !isdirectory(minpac_dir)
  silent! execute printf('!git clone https://github.com/k-takata/minpac.git %s', minpac_dir)
endif

g:plugpac_plugin_conf_path = $v .. '/rc'
g:plugpac_default_type = 'delay'

# plugins [[[1
call plugpac#Begin({
  progress_open: 'tab',
  status_open: 'vertical',
  verbose: 2,
})
Pack 'k-takata/minpac', {'type': 'opt'}

Pack 'lifepillar/vim-gruvbox8', { 'type': 'start' }
Pack 'ojroques/vim-oscyank', { 'type': 'delay' }
Pack 'tomtom/tcomment_vim', { 'type': 'delay' }
Pack 'tpope/vim-sensible', { 'type': 'start' }
Pack 'tpope/vim-surround', { 'type': 'delay' }
Pack 'tpope/vim-unimpaired', { 'type': 'delay' }

if !g:minimal_plugins
  # General [[[2
  # Enhance [[[3
  Pack 'AndrewRadev/linediff.vim', { 'on': 'Linediff' }
  Pack 'Eliot00/auto-pairs'
  Pack 'airblade/vim-rooter', { 'on': 'Rooter' }
  Pack 'cocopon/vaffle.vim', { 'type': 'start' }
  Pack 'editorconfig/editorconfig-vim'
  Pack 'itchyny/vim-cursorword'
  Pack 'lfv89/vim-interestingwords', { 'on': '<Plug>InterestingWords' }
  Pack 'luochen1990/rainbow'
  Pack 'machakann/vim-highlightedyank'
  Pack 'mbbill/undotree', { 'on': 'UndotreeToggle' }
  Pack 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
  Pack 'romainl/vim-qf'
  Pack 'skywind3000/vim-terminal-help'
  Pack 'tpope/vim-characterize'
  Pack 'tpope/vim-repeat'
  Pack 'vim-voom/VOoM', { 'on': 'Voom' }

  Pack 'junegunn/fzf'
  Pack 'junegunn/fzf.vim'
  Pack 'justinmk/vim-gtfo'
  Pack 'skywind3000/asyncrun.vim'
  Pack 'tyru/open-browser.vim'
  Pack 'tpope/vim-eunuch'

  Pack 'Yggdroot/LeaderF', { 'do': "packadd LeaderF \| LeaderfInstallCExtension" }

  Pack 'chrisbra/NrrwRgn'

  Pack 'bennyyip/vim-highlightedyank'
  # Vim [[[3
  Pack 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
  Pack 'tyru/restart.vim', { 'on': 'Restart' }
  # VCS [[[3
  # Pack 'shumphrey/fugitive-gitlab.vim'
  # Pack 'tommcdo/vim-fubitive'
  Pack 'Eliot00/git-lens.vim'
  Pack 'junegunn/gv.vim', { 'on': 'GV' }
  Pack 'rhysd/conflict-marker.vim'
  Pack 'tommcdo/vim-fugitive-blame-ext'
  Pack 'tpope/vim-fugitive'
  Pack 'tpope/vim-rhubarb'
  Pack 'tpope/vim-git'
  # Text Edit [[[3
  Pack 'AndrewRadev/sideways.vim'
  Pack 'AndrewRadev/splitjoin.vim'
  Pack 'andymass/vim-matchup'
  Pack 'bergercookie/vim-debugstring'
  Pack 'bootleq/vim-cycle'
  Pack 'junegunn/vim-easy-align'
  Pack 'svermeulen/vim-yoink'
  Pack 'tommcdo/vim-exchange', { 'on': '<Plug>(Exchange)' }
  Pack 'tpope/vim-abolish'
  Pack 'tpope/vim-apathy'
  Pack 'tpope/vim-capslock'
  Pack 'tpope/vim-rsi'

  Pack 'michaeljsmith/vim-indent-object'
  Pack 'wellle/targets.vim'

  Pack 'dyng/ctrlsf.vim'
  Pack 'yegappan/greplace'
  # Move Around [[[3
  Pack 'bennyyip/is.vim'
  Pack 'haya14busa/vim-asterisk'
  Pack 'justinmk/vim-sneak', { 'on': ['<Plug>Sneak_S', '<Plug>Sneak_s', '<Plug>Sneak_f', '<Plug>Sneak_F', '<Plug>Sneak_t' ] }
  Pack 'markonm/traces.vim'
  # Pack 'monkoose/vim9-stargate'
  # *nix Stuff [[[3
  Pack 'christoomey/vim-tmux-navigator'
  Pack 'lilydjwg/fcitx.vim'
  # Appearance [[[3
  Pack 'itchyny/lightline.vim'
  Pack 'monkoose/boa-vim'
  # Pack 'Bakudankun/qline.vim', {'type': 'delay'}

  Pack 'mhinz/vim-startify', { 'type': 'delay' }
  # Language [[[2
  Pack 'neoclide/coc.nvim', { 'branch': 'release' }
  Pack 'dense-analysis/ale'

  Pack 'PProvost/vim-ps1', { 'for': ['ps1', 'ps1xml'] }
  Pack 'Shiracamus/vim-syntax-x86-objdump-d'
  Pack 'cespare/vim-toml', { 'for': 'toml' }
  Pack 'derekwyatt/vim-scala', { 'for': 'scala' }
  Pack 'ekalinin/Dockerfile.vim', { 'for': ['yaml.docker-compose', 'Dockerfile'] }
  Pack 'chr4/nginx.vim', { 'type': 'opt' }
  Pack 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
  Pack 'tikhomirov/vim-glsl', { 'for': 'glsl' }
  Pack 'Firef0x/PKGBUILD.vim', { 'for': ['PKGBUILD', 'PKGINFO'] }
  Pack 'chrisbra/csv.vim', { 'type': 'opt' }
  # Python [[[3
  Pack 'vim-python/python-syntax', { 'for': 'python'}
  # Typescript [[[3
  Pack 'leafgarland/typescript-vim', { 'for': 'typescript'}
  Pack 'peitalin/vim-jsx-typescript'
  # Web [[[3
  Pack 'lilydjwg/colorizer'
  Pack 'mattn/emmet-vim', { 'for': ['xml', 'html', 'css', 'javascript', 'typescript', 'typescript.tsx'] }
  Pack 'othree/html5.vim', {'for': 'html' }
  Pack 'tpope/vim-jdaddy'
  # Markup [[[3
  Pack 'Rykka/riv.vim', { 'for': 'rst' }
  Pack 'iamcco/markdown-preview.nvim', { 'do': "packadd markdown-preview.nvim \| call mkdp#util#install()" }
  Pack 'preservim/vim-markdown', { type: 'start' }
  # Pack 'lervag/vimtex', {'for': 'tex' }
  # Text [[[3
  Pack 'hotoo/pangu.vim'
endif
plugpac#End()
# plugpac helpers [[[1
def PackList(A: string, ...args: list<any>): list<string>
  plugpac#Init()
  const pluglist = minpac#getpluglist()->keys()->sort()
  return pluglist->Utils.Matchfuzzy(A)
enddef

command! -nargs=1 -complete=customlist,PackList
      \ PackUrl call plugpac#Init() | call openbrowser#open(
      \    minpac#getpluginfo(<q-args>).url)

command! -nargs=1 -complete=customlist,PackList
      \ PackDir call plugpac#Init() | execute 'edit ' .. minpac#getpluginfo(<q-args>).dir

command! -nargs=1 -complete=customlist,PackList
      \ PackRc call plugpac#Init() | execute 'edit ' ..
      \ g:plugpac_plugin_conf_path .. '/' ..
      \ substitute(minpac#getpluginfo(<q-args>).name, '\.n\?vim$', '', '') .. '.vim'

command! -nargs=1 -complete=customlist,PackList
      \ PackRcPre call plugpac#Init() | execute 'edit ' ..
      \ g:plugpac_plugin_conf_path .. '/pre-' ..
      \ substitute(minpac#getpluginfo(<q-args>).name, '\.n\?vim$', '', '') .. '.vim'
# ]]]

#  vim:fdm=marker:fmr=[[[,]]]:ft=vim
