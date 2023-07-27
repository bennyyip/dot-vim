vim9script
# Plugin: dense-analysis/ale

# let g:ale_set_loclist = 0
# let g:ale_set_quickfix = 1
g:ale_linters_explicit = 1
g:ale_fix_on_save = 0
g:ale_fixers = {
  'vim': [],
  'tex': [],
  'dockerfile': [],
  'rust': [
    'rustfmt',
  ],
  'c': [
    'clang-format',
  ],
  'cpp': [
    'clang-format',
  ],
  'python': [
    'black',
    'isort',
    'ruff',
  ],
  'css': [
    'prettier',
  ],
  'javascript': [
    'prettier',
  ],
  'typescript': [
    'eslint',
    'prettier',
  ],
  'bash': [
    'shfmt'
  ],
  'sh': [
    'shfmt'
  ],
  'json': [
    'jq',
  ],
  'go': [
    'goimports',
  ],
  'html': [
    'tidy',
  ],
  'yaml': [
    'prettier',
  ],
  'proto': [
    'protolint',
  ],
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
