vim9script

const is_ssh = $SSH_CONNECTION != ""
const is_win = has('win32')

const package_name = g:minimal_plugins ? 'minimal' : 'minpac'
const minpac_dir = $'{$v}/pack/{package_name}/opt/minpac'
if !isdirectory(minpac_dir)
  silent! execute printf('!git clone https://github.com/k-takata/minpac.git %s', minpac_dir)
endif

g:plugpac_plugin_conf_path = $v .. '/rc'
g:plugpac_default_type = 'delay'
# plugins [[[1
# Builtin [[[2

if !is_win
  # :Man <leader>K
  runtime! ftplugin/man.vim
endif

packadd! cfilter
try
  # debian 12
  packadd! helptoc
catch
endtry

# ]]]
import autoload "utils.vim"
def AfterFun()
  vim9cmd source $v/keymap.vim
  utils.MapMeta()
enddef
call plugpac#Begin({
  # progress_open: tab',
  quiet: g:minimal_plugins,
  package_name: package_name,
  status_open: 'vertical',
  verbose: 2,
  after_hook: AfterFun,
})
Pack 'k-takata/minpac', {'type': 'opt'}

Pack 'lifepillar/vim-gruvbox8', { 'type': 'opt' }
if is_ssh
  Pack 'ojroques/vim-oscyank', { 'type': 'delay', 'rev': 'main' } # <leader>c <leader>cc <A-w>
endif
if v:version >= 901 && !getcompletion('comment', 'packadd')->empty()
  autocmd_add([{
    event: 'VimEnter',
    pattern: '*',
    group: 'PlugPac',
    once: true,
    cmd: 'timer_start(1, (_) => execute("packadd comment"))',
  }])
else
  Pack 'tomtom/tcomment_vim', { 'type': 'delay' }
endif
Pack 'bootleq/vim-cycle'
Pack 'itchyny/lightline.vim'
Pack 'machakann/vim-sandwich', { type: 'start' }

if g:minimal_plugins
  g:loaded_netrw       = 0
  g:loaded_netrwPlugin = 0
  packadd matchit
else
  # Lab [[[2
  Pack 'rhysd/vim-gfm-syntax'
  Pack 'mg979/vim-visual-multi'
  Pack 'ubaldot/vim9-conversion-aid'
  Pack 'dstein64/vim-startuptime', { 'on': 'StartupTime' }
  Pack 'chrisbra/vim_faq'
  # Pack 'yegappan/mru'
  # Pack 'yegappan/fileselect'
  # Pack 'hahdookin/miniterm.vim'
  # Enhance [[[2
  Pack 'LunarWatcher/auto-pairs'
  Pack 'Konfekt/vim-alias'
  # Pack 'andymass/vim-matchup'
  packadd matchit
  Pack 'nickspoons/vim-movefast'
  Pack 'airblade/vim-rooter', { 'type': 'start' } # <leader>r
  Pack 'mhinz/vim-startify', { 'type': 'start' }
  # Pack 'Yggdroot/LeaderF', { 'do': "packadd LeaderF \| LeaderfInstallCExtension" }
  Pack 'bennyyip/tasks.vim'
  # Pack 'romainl/vim-qf' # { } H L
  Pack 'habamax/vim-shout'
  Pack 'tpope/vim-eunuch'

  Pack 'habamax/vim-dir', { 'type': 'start' }

  if has("patch-9.0.1811")
    autocmd_add([{
      event: 'VimEnter',
      pattern: '*',
      group: 'PlugPac',
      once: true,
      cmd: 'timer_start(1, (_) => execute("packadd editorconfig"))',
    }])
  else
    Pack 'editorconfig/editorconfig-vim'
  endif

  Pack 'AndrewRadev/linediff.vim', { 'on': 'Linediff' } # <C-g>d
  Pack 'itchyny/vim-cursorword'
  Pack 'lfv89/vim-interestingwords'
  Pack 'luochen1990/rainbow'
  Pack 'mbbill/undotree', { 'on': 'UndotreeToggle' }
  Pack 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
  Pack 'tpope/vim-characterize'
  Pack 'tpope/vim-repeat', { type: 'start' }
  Pack 'chrisbra/NrrwRgn' # :NR :NW :NRV :WR
  # Pack 'justinmk/vim-gtfo' # gof got
  # Pack 'bennyyip/vim-highlightedyank'
  Pack 'ubaldot/vim-highlight-yanked'
  if !is_win
    Pack 'lilydjwg/fcitx.vim'
  endif
  Pack 'girishji/scope.vim'
  Pack 'bennyyip/miniterm.vim'
  # Motion and Edit [[[2
  Pack 'machakann/vim-swap' # g, g. gs gS
  Pack 'yegappan/taglist'
  Pack 'bennyyip/vim-debugstring' # <leader>ds
  Pack 'tommcdo/vim-lion' # <count>gl<motion><char>
  Pack 'svermeulen/vim-yoink' # :Yanks
  Pack 'tommcdo/vim-exchange', { 'on': '<Plug>(Exchange)' } # gx gxx gxg
  Pack 'tpope/vim-abolish'
  Pack 'tpope/vim-apathy' # 'path'
  Pack 'Konfekt/vim-scratchpad'

  # Pack 'michaeljsmith/vim-indent-object'

  Pack 'justinmk/vim-sneak', { 'on': ['<Plug>Sneak_S', '<Plug>Sneak_s', '<Plug>Sneak_f', '<Plug>Sneak_F', '<Plug>Sneak_t'] }
  Pack 'markonm/traces.vim'
  # Pack 'monkoose/vim9-stargate'
  # VCS [[[2
  Pack 'Eliot00/git-lens.vim'
  Pack 'junegunn/gv.vim', { 'on': 'GV' }
  Pack 'rhysd/conflict-marker.vim' # [x ]x
  Pack 'tommcdo/vim-fugitive-blame-ext'
  Pack 'tpope/vim-fugitive', { type: 'start' }
  # Pack 'tpope/vim-rhubarb'
  # Pack 'errael/splice9', { type: 'start', frozen: true }
  # Language [[[2
  if executable('ctags')
    Pack 'ludovicchabant/vim-gutentags', { type: 'start' }
  endif
  # Pack 'bennyyip/lsp', { type: 'start', branch: 'dev' }
  Pack 'yegappan/lsp', { type: 'start', branch: 'main' }

  Pack 'Konfekt/vim-compilers'
  # Pack 'Konfekt/vim-formatprgs'

  Pack 'girishji/devdocs.vim'
  # Pack 'rhysd/devdocs.vim'
  Pack 'Shiracamus/vim-syntax-x86-objdump-d'
  Pack 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
  Pack 'tikhomirov/vim-glsl', { 'for': 'glsl' }
  Pack 'chrisbra/csv.vim', { 'type': 'opt' }
  Pack 'pearofducks/ansible-vim'

  Pack 'tridactyl/vim-tridactyl'

  Pack 'bfrg/vim-jq'
  Pack 'bfrg/vim-jqplay'
  Pack 'vim-python/python-syntax'
  Pack 'lervag/vimtex'
  # Typescript [[[3
  # Pack 'leafgarland/typescript-vim', { 'for': 'typescript' }
  Pack 'MaxMEllon/vim-jsx-pretty'
  # Web [[[3
  Pack 'BourgeoisBear/clrzr'
  # Pack 'mattn/emmet-vim', { 'for': ['xml', 'html', 'css', 'javascript', 'typescript', 'typescript.tsx'] }
  # Pack 'othree/html5.vim', { 'for': 'html' }
  # Pack "hail2u/vim-css3-syntax", { 'for': 'css' }
  # Markup [[[3
  if is_win
    # Pack 'iamcco/markdown-preview.nvim', { 'do': "packadd markdown-preview.nvim \| call mkdp#util#install()" }
    Pack 'iamcco/markdown-preview.nvim'
  endif
  # ]]]
  # ]]]
  Pack 'SirVer/ultisnips'
  # Pack 'Shougo/neosnippet.vim', { type: 'opt'}
  Pack 'honza/vim-snippets', { 'type': 'opt' }
endif
plugpac#End()
# plugpac helpers [[[1
import autoload "plugpac_helper.vim" as P
command! PackSummary P.PackSummary()
const PackList = P.PackList
command! -nargs=1 -complete=customlist,PackList PackUrl   P.PackUrl(<q-args>)
command! -nargs=1 -complete=customlist,PackList PackDir   P.PackDir(<q-args>)
command! -nargs=1 -complete=customlist,PackList PackRc    P.PackRc(<q-args>)
command! -nargs=1 -complete=customlist,PackList PackRcPre P.PackRcPre(<q-args>)
command! PackUnusedRC cexpr P.PackUnusedRC()->map((_, x) => $"{x}:1:1: Unused")
# ]]]
#  vim:fdm=marker:fmr=[[[,]]]:ft=vim
