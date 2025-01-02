vim9script
# Plugin: dense-analysis/ale

# disable by default
ALEDisable

# https://github.com/dense-analysis/ale/issues/4804
autocmd_delete([{'event': 'InsertEnter', 'group': 'ALEEvents'}])

# let g:ale_set_loclist = 0
# let g:ale_set_quickfix = 1
# g:ale_disable_lsp = 1
g:ale_use_global_executables = v:true
g:ale_linters_explicit = 1
g:ale_fix_on_save = 0
g:ale_fixers = {
  'dockerfile': [],
  'lisp': [],
  'ps1': [],
  'tex': [],
  'vim': [],
  'xonsh': [],
  'conf': [],
  'bash': [ 'shfmt' ],
  'c': [ 'clang-format' ],
  'cs': [ 'dotnet-format' ],
  'cpp': [ 'clang-format' ],
  'go': [ 'goimports', ],
  'html': [ 'prettier', ],
  'css': [ 'prettier' ],
  'javascript': [ 'dprint', ],
  'markdown': [ 'dprint' ],
  'scss': [ 'prettier', ],
  'typescript': [ 'eslint', 'dprint', ],
  'json': [ 'dprint', ],
  'jsonc': [ 'biome', ],
  'proto': [ 'protolint', ],
  # 'python': [ 'black', 'isort', 'ruff' ],
  'python': [ 'ruff_format', 'ruff' ],
  'rust': [ 'rustfmt' ],
  'sh': [ 'shfmt' ],
  'yaml': [ 'prettier', ],
  'toml': [ 'dprint', ],
}
const general_ale_fixer = [
  'trim_whitespace',
  'remove_trailing_lines',
]
map(g:ale_fixers, (k, v) => general_ale_fixer + v)
g:ale_sh_shfmt_options = '-i 2'
g:ale_json_jq_options = '--sort-keys'
g:ale_python_ruff_options = '--select I'
g:ale_dprint_use_global = 1

# g:ale_biome_use_global = 1

g:ale_linters = {
  'sh': ['shellcheck'],
  'bash': ['shell', 'shellcheck'],
  'zsh': ['shell', 'shellcheck'],
  'javascript': ['biome', 'eslint'],
  'typescript': ['biome', 'eslint'],
  'python': ['ruff'],
  'go': ['golint'],
  'yaml': [ 'yamllint' ],
  'vim': [],
}


# override ]s [s
nmap <silent> ]s <Plug>(ale_next_wrap)
nmap <silent> [s <Plug>(ale_previous_wrap)
nmap <silent> <leader>= <Plug>(ale_fix)
nmap <silent> <leader>+ <Plug>(ale_enable_buffer)
