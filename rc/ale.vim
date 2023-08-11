vim9script
# Plugin: dense-analysis/ale

# let g:ale_set_loclist = 0
# let g:ale_set_quickfix = 1
g:ale_linters_explicit = 1
g:ale_fix_on_save = 0
g:ale_fixers = {
  'dockerfile': [],
  'lisp': [],
  'ps1': [],
  'tex': [],
  'vim': [],
  'bash': [ 'shfmt' ],
  'c': [ 'clang-format' ],
  'cpp': [ 'clang-format' ],
  'css': [ 'prettier' ],
  'go': [ 'goimports', ],
  'html': [ 'tidy', ],
  'javascript': [ 'prettier', ],
  'json': [ 'jq', ],
  'markdown': [ 'prettier' ],
  'proto': [ 'protolint', ],
  'python': [ 'black', 'isort', 'ruff' ],
  'rust': [ 'rustfmt' ],
  'scss': [ 'prettier', ],
  'sh': [ 'shfmt' ],
  'typescript': [ 'eslint', 'prettier', ],
  'yaml': [ 'prettier', ],
}
const general_ale_fixer = [
  'trim_whitespace',
  'remove_trailing_lines',
]
map(g:ale_fixers, (k, v) => general_ale_fixer + v)
g:ale_sh_shfmt_options = '-i 2'
g:ale_json_jq_options = '--sort-keys'

g:ale_linters = {
  'sh': ['shellcheck'],
  'bash': ['shell', 'shellcheck'],
  'zsh': ['shell', 'shellcheck'],
  'javascript': ['eslint'],
  'typescript': ['eslint'],
  'python': ['ruff'],
  'go': ['golint'],
}

# override ]s [s
nmap <silent> ]s <Plug>(ale_next_wrap)
nmap <silent> [s <Plug>(ale_previous_wrap)
nmap <silent> <leader>= <Plug>(ale_fix)
nmap <silent> <leader>+ <Plug>(ale_enable_buffer)
