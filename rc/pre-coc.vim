vim9script
# Plugin: neoclide/coc.nvim

g:coc_data_home = $v .. '/coc/'

g:coc_global_extensions = [
  'coc-json',
  'coc-pyright',
  'coc-snippets',
  'coc-spell-checker',
  'coc-tsserver',
  # 'coc-vimlsp',
  'coc-yaml',
  'coc-css',
  'coc-biome',
  '@yaegassy/coc-ansible',
  '@yaegassy/coc-marksman'
]

g:coc_filetype_map = {
  'yaml.ansible': 'ansible',
}

nmap <silent> <Plug>(meta-j) <Plug>(coc-definition)
nmap <silent> <Plug>(meta-m) <Plug>(coc-references)
