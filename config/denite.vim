" Use Ag for file_rec
call denite#custom#var('file_rec', 'command',
      \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#source(
      \ 'file_rec', 'sorters', ['sorter_sublime'])

" Use Ag for grep
call denite#custom#var('grep', 'Command', ['Ag'])
call denite#custom#var('grep', 'Recursive_opts', [])
call denite#custom#var('grep', 'Default_opts', ['--Follow', '--No-Group', '--No-Color'])

" Change default prompt
call denite#custom#option('default', 'prompt', '>')

" Change ignore_globs
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

nnoremap <silent> <leader>ff :<C-u>Denite file_rec -no-statusline<CR>
nnoremap <silent> <leader>fr :<C-u>Denite file_mru<CR>
nnoremap <silent> <leader>ag :<C-u>Denite grep<CR>
