vim9script

g:loaded_2html_plugin     = 1
g:loaded_getscriptPlugin  = 1
g:loaded_gzip             = 1
g:loaded_logiPat          = 1
# g:loaded_manpager_plugin  = 1
# g:loaded_matchparen       = 1
g:loaded_rrhelper         = 1
g:loaded_spellfile_plugin = 1
g:loaded_tarPlugin        = 1
g:loaded_vimballPlugin    = 1
g:loaded_zipPlugin        = 1
g:loaded_netrw            = 1
g:loaded_netrwPlugin      = 1
g:loaded_tutor_mode_plugin = 1

g:nogx = true
g:vimsyn_folding = 'f'

g:load_black = 1
g:loaded_fzf = 1

legacy let c_no_comment_fold = 1
legacy let c_comment_strings = 1

# this makes sure that shell scripts are highlighted
# as bash scripts and not sh scripts
g:is_posix = 1

g:python_highlight_all = 1
g:markdown_fenced_languages = ['html', 'datacorejsx=jsx', 'dataviewjs=javascript', 'js=javascript', 'ruby', 'zsh', 'bash=sh', 'python', 'ocaml', 'base=yaml']

g:snips_author = 'Ben Yip'
g:obsidian_vault = $HOME .. '/Obsidian-Vault'

$RIPGREP_CONFIG_PATH = $HOME .. '/.ripgreprc'

