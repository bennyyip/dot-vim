let g:ale_disable_lsp = 1

# if plugpac#HasPlugin("lightline-ale") " [[[1
#   let g:lightline.component_expand = {
#         \  'linter_checking': 'lightline#ale#checking',
#         \  'linter_infos': 'lightline#ale#infos',
#         \  'linter_warnings': 'lightline#ale#warnings',
#         \  'linter_errors': 'lightline#ale#errors',
#         \  'linter_ok': 'lightline#ale#ok',
#         \ }
#   let g:lightline.component_type = {
#         \     'linter_checking': 'right',
#         \     'linter_infos': 'right',
#         \     'linter_warnings': 'warning',
#         \     'linter_errors': 'error',
#         \     'linter_ok': 'right',
#         \ }

#   let g:lightline.active.right = [
#         \  [  'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok', 'lineinfo', ],
#         \  [ 'percent' ],
#         \  [ 'cocstatus', 'asyncrun', 'fileformat', 'fileencoding', 'filetype' ] ]

#   let g:lightline#ale#indicator_checking = "\uf110"
#   " let g:lightline#ale#indicator_infos = "\uf129"
#   " let g:lightline#ale#indicator_warnings = "\uf071"
#   " let g:lightline#ale#indicator_errors = "\uf05e"
#   let g:lightline#ale#indicator_ok = "\uf00c"
# endif
