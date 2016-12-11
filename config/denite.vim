" Use Ag for file_rec 
call denite#custom#var('file_rec', 'command',
      \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

" Use Ag for grep
call denite#custom#var('grep', 'Command', ['Ag'])
call denite#custom#var('grep', 'Recursive_opts', [])
call denite#custom#var('grep', 'Default_opts', ['--follow', '--no-group', '--no-color'])

" Change default prompt
call denite#custom#option('default', 'prompt', '>')

" Change ignore_globs
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

" Sort behavior
call denite#custom#source(
      \ 'file_rec', 'sorters', ['sorter_sublime'])

" Key mapping
nnoremap <silent> <leader>ff :<C-u>Denite file_rec -no-statusline<CR>
nnoremap <silent> <leader>fr :<C-u>Denite file_mru<CR>
" u for unite, predecessor of denite
nnoremap <silent> <leader>u+ :<C-u>Denite -resume -immediately  -select=+1<CR>
nnoremap <silent> <leader>u- :<C-u>Denite -resume -immediately  -select=-1<CR>
nnoremap <silent> <leader>ug :<C-u>Denite grep<CR>
nnoremap <silent> <leader>uj :<C-u>Denite line<CR>
nnoremap <silent> <leader>ur :<C-u>Denite -resume<CR>
nnoremap <silent> <leader>ut :<C-u>Denite filetype<CR>
nnoremap <silent> <leader>uw :<C-u>DeniteCursorWord grep<CR><CR>
nnoremap <silent> <leader>uy :<C-u>Denite neoyank<CR>

