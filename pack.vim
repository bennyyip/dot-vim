vim9script
import autoload "utils.vim"

const is_win = has('win32')

const package_name = 'minpac'
const minpac_dir = $'{$MYVIMDIR}/pack/{package_name}/opt/minpac'

command MinpacInstall {
  if !isdirectory(minpac_dir)
    silent! execute printf('!git clone https://github.com/k-takata/minpac.git %s', minpac_dir)
    :qall
  endif
}

# Builtin [[[1
timer_start(0, (_) => {
  if !getcompletion('helptoc', 'packadd')->empty()
    packadd helptoc
  endif
  if !getcompletion('cfilter', 'packadd')->empty()
    packadd cfilter
  endif
  if !getcompletion('matchit', 'packadd')->empty()
    packadd matchit
  endif
  if !getcompletion('comment', 'packadd')->empty()
    packadd comment
  endif
  if !getcompletion('editorconfig', 'packadd')->empty()
    packadd editorconfig
  endif
  if !getcompletion('termdebug', 'packadd')->empty()
    packadd termdebug
  endif
  if !getcompletion('hlyank', 'packadd')->empty()
    packadd hlyank
    g:hlyank_hlgroup = "Search"
    g:hlyank_duration = 500
  endif

  if !is_win
    packadd vim-man
  endif
  packadd formatters
  packadd misc
  packadd ocaml
  source $MYVIMDIR/rc/pre-vim-sandwich.vim
  packadd vim-sandwich
  source $MYVIMDIR/rc/vim-sandwich.vim
  packadd vim-scratchpad
  source $MYVIMDIR/rc/vim-dir.vim

  utils.MapMeta()
})
silent! packadd minpac
if !exists('g:loaded_minpac')
  finish
endif
# ]]]

g:plugpac_plugin_conf_path = $MYVIMDIR .. '/rc'
g:plugpac_default_type = 'delay'

au User PlugpacPost {
  utils.MapMeta()
  doautocmd BufEnter
  normal! <C-L>
}

call plugpac#Begin({
  # progress_open: tab',
  quiet: false,
  package_name: package_name,
  status_open: 'vertical',
  verbose: 2,
})
Pack 'k-takata/minpac', {'type': 'opt'}

if getcompletion('retrobox', 'color')->empty()
  Pack 'lifepillar/vim-gruvbox8', { 'type': 'opt' }
endif
if getcompletion('comment', 'packadd')->empty()
  Pack 'tomtom/tcomment_vim'
endif
if getcompletion('editorconfig', 'packadd')->empty()
  Pack 'editorconfig/editorconfig-vim'
endif
if getcompletion('hlyank', 'packadd')->empty()
  Pack 'ubaldot/vim-highlight-yanked'
endif

# Lab [[[1
# Enhance [[[1
Pack 'dstein64/vim-startuptime'
Pack 'junegunn/goyo.vim'
Pack 'bootleq/vim-cycle'
Pack 'LunarWatcher/auto-pairs'
Pack 'Konfekt/vim-alias'
Pack 'nickspoons/vim-movefast'
Pack 'airblade/vim-rooter' # <leader>r
Pack 'bennyyip/tasks.vim'
Pack 'tpope/vim-eunuch'
Pack 'AndrewRadev/linediff.vim'
Pack 'itchyny/vim-cursorword'
Pack 'lfv89/vim-interestingwords'
Pack 'luochen1990/rainbow'
Pack 'mbbill/undotree'
Pack 'tpope/vim-characterize'
Pack 'tpope/vim-repeat'
Pack 'chrisbra/NrrwRgn' # :NR :NW :NRV :WR
if !is_win && exists('$DISPLAY')
  Pack 'lilydjwg/fcitx.vim'
endif
Pack 'bennyyip/miniterm.vim'
# Motion and Edit [[[1
Pack 'machakann/vim-swap' # g, g. gs gS
Pack 'bennyyip/vim-debugstring' # <leader>ds
Pack 'tommcdo/vim-lion' # <count>gl<motion><char>
Pack 'tommcdo/vim-exchange' # gx gxx gxg
Pack 'tpope/vim-abolish'

if !is_win # system() is slow
  Pack 'tpope/vim-apathy' # 'path'
endif
Pack 'liuchengxu/vista.vim'

Pack 'justinmk/vim-sneak'
Pack 'markonm/traces.vim'
# VCS [[[1
Pack 'Eliot00/git-lens.vim'
Pack 'rhysd/conflict-marker.vim' # [x ]x
Pack 'tommcdo/vim-fugitive-blame-ext'
Pack 'tpope/vim-fugitive'
# Language [[[1
Pack 'yegappan/lsp', { branch: 'main', 'type': 'delay' }
Pack 'Konfekt/vim-compilers'
Pack 'girishji/devdocs.vim'
Pack 'Shiracamus/vim-syntax-x86-objdump-d'
Pack 'octol/vim-cpp-enhanced-highlight'
Pack 'chrisbra/csv.vim'
if !is_win
  Pack 'pearofducks/ansible-vim'
endif
Pack 'tridactyl/vim-tridactyl'
Pack 'bfrg/vim-jq'
Pack 'bfrg/vim-jqplay'
Pack 'lervag/vimtex'
# Web [[[3
Pack 'MaxMEllon/vim-jsx-pretty'
Pack 'BourgeoisBear/clrzr'
# Pack 'mattn/emmet-vim', { 'for': ['xml', 'html', 'css', 'javascript', 'typescript', 'typescript.tsx'] }
# Markup [[[3
if is_win
  # Pack 'iamcco/markdown-preview.nvim', { 'do': "packadd markdown-preview.nvim \| call mkdp#util#install()" }
  Pack 'iamcco/markdown-preview.nvim'
endif
# ]]]
# ]]]
Pack 'SirVer/ultisnips'
Pack 'honza/vim-snippets', { 'type': 'opt' }
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
