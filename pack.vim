vim9script

import autoload "./autoload/utils.vim" as Utils
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
g:loaded_2html_plugin = 1
g:loaded_getscriptPlugin = 1
g:loaded_gzip = 1
g:loaded_logiPat = 1
g:loaded_logipat = 1
g:loaded_manpager_plugin = 1
# let g:loaded_matchparen = 1
g:loaded_rrhelper = 1
g:loaded_spellfile_plugin = 1
g:loaded_tarPlugin = 1
g:loaded_vimballPlugin = 1
g:loaded_zipPlugin = 1

if !is_win
  # :Man <leader>K
  runtime! ftplugin/man.vim
endif

# packadd! editexisting
packadd! helptoc
packadd! matchit
# ]]]
call plugpac#Begin({
  # progress_open: tab',
  quiet: g:minimal_plugins || v:true,
  package_name: package_name,
  status_open: 'vertical',
  verbose: 2,
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
Pack 'bennyyip/lightline.vim' # fork to disable in nofile
Pack 'machakann/vim-sandwich'

if !g:minimal_plugins
  # Lab [[[2
  # Pack 'zhimsel/vim-stay', {'type': 'start'}
  # Pack 'Konfekt/FastFold'
  Pack 'Konfekt/vim-scratchpad'
  Pack 'dstein64/vim-startuptime', { 'on': 'StartupTime' }
  # Enhance [[[2
  Pack 'AndrewRadev/linediff.vim', { 'on': 'Linediff' } # <C-g>d
  Pack 'airblade/vim-rooter', { 'type': 'start' } # <leader>r

  Pack 'mhinz/vim-startify', { 'type': 'delay' }

  g:loaded_netrw       = 1
  g:loaded_netrwPlugin = 1
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
  Pack 'itchyny/vim-cursorword'
  Pack 'lfv89/vim-interestingwords'
  Pack 'luochen1990/rainbow'
  Pack 'mbbill/undotree', { 'on': 'UndotreeToggle' }
  Pack 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
  Pack 'romainl/vim-qf' # { } H L
  Pack 'tpope/vim-characterize'
  Pack 'tpope/vim-repeat'

  Pack 'justinmk/vim-gtfo' # gof got
  Pack 'bennyyip/tasks.vim'
  # Pack 'habamax/vim-shout'
  # Pack 'skywind3000/asyncrun.vim'
  # if !is_ssh
  #   Pack 'tyru/open-browser.vim'
  # endif

  Pack 'tpope/vim-eunuch'

  Pack 'Yggdroot/LeaderF', { 'do': "packadd LeaderF \| LeaderfInstallCExtension" }

  Pack 'chrisbra/NrrwRgn' # :NR :NW :NRV :WR

  Pack 'bennyyip/vim-highlightedyank'
  Pack 'chrisbra/vim_faq'
  if !is_win
    Pack 'christoomey/vim-tmux-navigator'
    Pack 'lilydjwg/fcitx.vim'
  endif
  # Motion and Edit [[[2
  Pack 'machakann/vim-swap' # g, g. gs gS
  Pack 'bergercookie/vim-debugstring' # <leader>ds
  Pack 'tommcdo/vim-lion' # <count>gl<motion>=
  Pack 'svermeulen/vim-yoink' # :Yanks
  Pack 'tommcdo/vim-exchange', { 'on': '<Plug>(Exchange)' } # gx gxx gxg
  Pack 'tpope/vim-abolish'
  Pack 'tpope/vim-apathy' # 'path'

  Pack 'michaeljsmith/vim-indent-object'

  Pack 'dyng/ctrlsf.vim'
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
  Pack 'neoclide/coc.nvim', { 'branch': 'release' }
  # Pack 'dense-analysis/ale'
  # Pack 'maximbaz/lightline-ale'

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
  # Python [[[3
  Pack 'meatballs/vim-xonsh'
  # Typescript [[[3
  # Pack 'leafgarland/typescript-vim', { 'for': 'typescript' }
  # Pack 'peitalin/vim-jsx-typescript'
  # Web [[[3
  Pack 'BourgeoisBear/clrzr'
  Pack 'mattn/emmet-vim', { 'for': ['xml', 'html', 'css', 'javascript', 'typescript', 'typescript.tsx'] }
  # Pack 'othree/html5.vim', { 'for': 'html' }
  # Pack "hail2u/vim-css3-syntax", { 'for': 'css' }
  # Markup [[[3
  if is_win
    Pack 'iamcco/markdown-preview.nvim', { 'do': "packadd markdown-preview.nvim \| call mkdp#util#install()" }
  endif
endif
plugpac#End()
# plugpac helpers [[[1
def PackList(A: string, ...args: list<any>): list<string>
  plugpac#Init()
  const pluglist = minpac#getpluglist()->keys()->sort()
  return pluglist->Utils.Matchfuzzy(A)
enddef

command! PackSummary {
  plugpac#Init()
  const pluglist = minpac#getpluglist()
  echom $'{pluglist->len()} packages installed.'
}

command! -nargs=1 -complete=customlist,PackList PackUrl {
  plugpac#Init()
  const url = minpac#getpluginfo(<q-args>).url
  os#Open(url)
}

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
